import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/location_models.dart';
import 'web_search_service.dart';

class LlmException implements Exception {
  final String message;
  LlmException(this.message);
  @override
  String toString() => message;
}

/// Dart port of the original backend's `app/services/llm.py`: prompt
/// building + provider routing, now called directly from the client with
/// the user's own key (BYOK-only — see CLAUDE.md "Quyết định đã chốt
/// 2026-08-04 (đợt 2)"). No more free-tier/fallback: exactly one provider,
/// exactly one key, both chosen by the user in Settings.
class LlmService {
  /// Item-specific web search query templates (SDD §10 groundwork).
  static const Map<String, String> searchQueryTemplates = {
    'food': '{name} local food specialties must-try dishes',
    'best_time': '{name} best time to visit weather by season',
    'travel_tips': '{name} travel tips for tourists what to know before you go',
    'transport': '{name} public transportation getting around guide for tourists',
    'power': '{name} power plug type voltage SIM card eSIM for travelers',
    'currency': '{name} currency cash vs card payment tips for tourists',
    'safety_level': '{name} travel safety advisory common scams crime',
    'health': '{name} healthcare quality for tourists travel clinic',
    'water': '{name} tap water safe to drink',
    'insurance': '{name} travel insurance requirement recommendation',
    'language': '{name} official language spoken english proficiency',
    'etiquette': "{name} local customs etiquette dos and don'ts for tourists",
    'tipping': '{name} tipping culture custom restaurants taxis',
    'holidays': '{name} public holidays festivals calendar',
    'history': '{name} history background founding historical significance',
    'visa': '{name} visa requirements for tourists entry rules',
    'stay': '{name} best areas neighborhoods to stay for tourists',
    'cost': '{name} daily travel budget cost of living for tourists',
  };

  /// Items where getting it wrong is high-stakes — always append a
  /// disclaimer regardless of what the LLM produced (SDD §8).
  static const Map<String, String> riskDisclaimerItems = {
    'visa':
        "Visa rules change often and vary by nationality — verify with the destination's official immigration/embassy website before travel.",
    'insurance':
        "Coverage requirements vary by nationality and visa type — verify with your insurer and destination's official sources.",
  };

  static const Map<String, String> _providerEndpoints = {
    'groq': 'https://api.groq.com/openai/v1/chat/completions',
    'openrouter': 'https://openrouter.ai/api/v1/chat/completions',
    'openai': 'https://api.openai.com/v1/chat/completions',
  };

  static const Map<String, String> _providerDefaultModels = {
    'gemini': 'gemini-1.5-flash',
    'groq': 'llama-3.1-8b-instant',
    'openrouter': 'openai/gpt-4o-mini',
    'openai': 'gpt-4o-mini',
  };

  String _buildPrompt({
    required String itemId,
    required String locationName,
    required List<WebSearchResult> searchResults,
    required String detailLevel,
    required String contentLanguage,
    String extraContext = '',
  }) {
    final label = kChildLabels[itemId]!;
    final lengthHint = detailLevel == 'short'
        ? '1-2 short sentences for the summary, and a short paragraph (3-5 sentences) for detail'
        : '1-2 sentences for the summary, and a thorough multi-paragraph write-up for detail';

    var prompt = '''
You are summarizing travel information about "$locationName" for the
topic "$label". Use ONLY the search results below as your source of truth;
if they don't cover the topic, say so honestly instead of inventing facts.

Search results:
${WebSearchService.formatResultsForPrompt(searchResults)}

Write your answer in language code "$contentLanguage".
Respond with ONLY a JSON object, no markdown fences, matching exactly:
{"summary": "...", "detail": "..."}
Length: $lengthHint.
''';
    if (extraContext.isNotEmpty) {
      prompt += '\n\nAdditional structured data to ground your answer:\n$extraContext\n';
    }
    return prompt;
  }

  Map<String, dynamic> _extractJson(String text) {
    final match = RegExp(r'\{[\s\S]*\}').firstMatch(text);
    if (match == null) {
      throw LlmException('LLM response did not contain JSON: ${text.substring(0, text.length.clamp(0, 200))}');
    }
    return jsonDecode(match.group(0)!) as Map<String, dynamic>;
  }

  Future<String> _callGemini(String apiKey, String model, String prompt) async {
    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
    );
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ]
      }),
    );
    if (resp.statusCode == 429) throw LlmException('Gemini rate limit exceeded');
    if (resp.statusCode != 200) throw LlmException('Gemini request failed (${resp.statusCode}): ${resp.body}');
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    try {
      final candidates = data['candidates'] as List<dynamic>;
      final content = candidates.first['content'] as Map<String, dynamic>;
      final parts = content['parts'] as List<dynamic>;
      return parts.first['text'] as String;
    } catch (e) {
      throw LlmException('Unexpected Gemini response shape: $data');
    }
  }

  Future<String> _callOpenAiCompatible(String provider, String apiKey, String model, String prompt) async {
    final uri = Uri.parse(_providerEndpoints[provider]!);
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $apiKey'},
      body: jsonEncode({
        'model': model,
        'messages': [
          {'role': 'user', 'content': prompt}
        ],
        'temperature': 0.3,
      }),
    );
    if (resp.statusCode == 429) throw LlmException('$provider rate limit exceeded');
    if (resp.statusCode != 200) throw LlmException('$provider request failed (${resp.statusCode}): ${resp.body}');
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    try {
      final choices = data['choices'] as List<dynamic>;
      final message = choices.first['message'] as Map<String, dynamic>;
      return message['content'] as String;
    } catch (e) {
      throw LlmException('Unexpected $provider response shape: $data');
    }
  }

  Future<String> _callProvider(String provider, String apiKey, String model, String prompt) {
    if (provider == 'gemini') return _callGemini(apiKey, model, prompt);
    if (_providerEndpoints.containsKey(provider)) return _callOpenAiCompatible(provider, apiKey, model, prompt);
    throw LlmException('Unknown provider: $provider');
  }

  Future<ChildItem> summarizeItem({
    required String itemId,
    required String locationName,
    required List<WebSearchResult> searchResults,
    required String provider,
    required String apiKey,
    required String detailLevel,
    required bool showSources,
    required String contentLanguage,
    String extraContext = '',
  }) async {
    final prompt = _buildPrompt(
      itemId: itemId,
      locationName: locationName,
      searchResults: searchResults,
      detailLevel: detailLevel,
      contentLanguage: contentLanguage,
      extraContext: extraContext,
    );
    final model = _providerDefaultModels[provider] ?? 'gemini-1.5-flash';
    final raw = await _callProvider(provider, apiKey, model, prompt);
    final parsed = _extractJson(raw);
    final sources = showSources ? searchResults.map((r) => r.url).toList() : <String>[];

    return ChildItem(
      id: itemId,
      label: kChildLabels[itemId]!,
      source: 'llm',
      summary: (parsed['summary'] as String? ?? '').trim(),
      detail: (parsed['detail'] as String? ?? '').trim(),
      sources: sources,
      updatedAt: DateTime.now().toUtc(),
      warning: riskDisclaimerItems[itemId],
    );
  }
}
