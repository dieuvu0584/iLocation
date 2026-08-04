import 'dart:convert';

import 'package:http/http.dart' as http;

class WebSearchResult {
  final String title;
  final String url;
  final String snippet;
  const WebSearchResult({required this.title, required this.url, required this.snippet});
}

/// Tavily web search, called directly from the client (BYOK, optional — SDD
/// §3/§10; CLAUDE.md "Quyết định đã chốt"). If no key is configured, the
/// caller simply skips search grounding rather than treating this as fatal.
class WebSearchService {
  static const _url = 'https://api.tavily.com/search';

  Future<List<WebSearchResult>> search(String query, String apiKey, {int maxResults = 5}) async {
    final resp = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'api_key': apiKey,
        'query': query,
        'max_results': maxResults,
        'search_depth': 'basic',
      }),
    );
    if (resp.statusCode != 200) {
      throw Exception('Tavily search failed (${resp.statusCode})');
    }
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>? ?? [];
    return results.map((r) {
      final result = r as Map<String, dynamic>;
      return WebSearchResult(
        title: result['title'] as String? ?? '',
        url: result['url'] as String? ?? '',
        snippet: result['content'] as String? ?? '',
      );
    }).toList();
  }

  static String formatResultsForPrompt(List<WebSearchResult> results) {
    if (results.isEmpty) return '(no search results found)';
    return results
        .asMap()
        .entries
        .map((e) => '[${e.key + 1}] ${e.value.title}\n${e.value.url}\n${e.value.snippet}')
        .join('\n\n');
  }
}
