import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../l10n/locale_codes.dart';
import '../../models/settings_models.dart';
import '../../state/app_settings.dart';
import '../../theme/colors.dart';
import '../../widgets/common/settings_scaffold.dart';

/// ~35 popular world languages (2026-08-05). Each has an `app_<code>.arb`
/// file under `lib/l10n/`; languages without full translations yet simply
/// fall back to English per-string, since `AppLocalizations<Code>` extends
/// the English base class and only overrides the keys it has (Dart/Flutter
/// gen-l10n behavior — see the generated classes in `lib/l10n/generated/`).
/// Content language reuses the same list — the LLM can write in any of
/// these regardless of ARB completeness.
const _kSupportedUiLocales = {
  'en': 'English',
  'vi': 'Tiếng Việt',
  'fr': 'Français',
  'es': 'Español',
  'de': 'Deutsch',
  'pt': 'Português',
  'it': 'Italiano',
  'nl': 'Nederlands',
  'ru': 'Русский',
  'pl': 'Polski',
  'tr': 'Türkçe',
  'ar': 'العربية',
  'hi': 'हिन्दी',
  'bn': 'বাংলা',
  'ur': 'اردو',
  'fa': 'فارسی',
  'id': 'Bahasa Indonesia',
  'ms': 'Bahasa Melayu',
  'th': 'ไทย',
  'ja': '日本語',
  'ko': '한국어',
  'zh': '中文（简体）',
  'zh_Hant': '中文（繁體）',
  'fil': 'Filipino',
  'sv': 'Svenska',
  'nb': 'Norsk bokmål',
  'da': 'Dansk',
  'fi': 'Suomi',
  'el': 'Ελληνικά',
  'he': 'עברית',
  'cs': 'Čeština',
  'ro': 'Română',
  'hu': 'Magyar',
  'uk': 'Українська',
  'sw': 'Kiswahili',
};
const _kSupportedContentLanguages = _kSupportedUiLocales;

/// SDD §7.1: UI language and content language are two independent settings
/// — don't let one imply the other.
class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appSettings = context.watch<AppSettings>();

    return SettingsScaffold(
      title: l10n.languageSettingsTitle,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          SettingsSectionLabel(l10n.uiLanguage),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _Dropdown<String?>(
              value: appSettings.uiLocale == null ? null : localeToCode(appSettings.uiLocale!),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.systemDefault)),
                ..._kSupportedUiLocales.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))),
              ],
              onChanged: (value) => appSettings.setUiLocale(value == null ? null : localeFromCode(value)),
            ),
          ),
          SettingsSectionLabel(l10n.contentLanguage),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
            child: Text(l10n.contentLanguageDesc, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _Dropdown<String>(
              value: appSettings.contentLanguage,
              items: _kSupportedContentLanguages.entries
                  .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (value) {
                if (value != null) appSettings.setContentLanguage(value);
              },
            ),
          ),
          SettingsSectionLabel(l10n.distanceUnit),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SegmentedButton<DistanceUnit>(
              segments: [
                ButtonSegment(value: DistanceUnit.km, label: Text(l10n.km)),
                ButtonSegment(value: DistanceUnit.miles, label: Text(l10n.miles)),
              ],
              selected: {appSettings.distanceUnit},
              onSelectionChanged: (s) => appSettings.setDistanceUnit(s.first),
            ),
          ),
          SettingsSectionLabel(l10n.temperatureUnit),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SegmentedButton<TemperatureUnit>(
              segments: [
                ButtonSegment(value: TemperatureUnit.celsius, label: Text(l10n.celsius)),
                ButtonSegment(value: TemperatureUnit.fahrenheit, label: Text(l10n.fahrenheit)),
              ],
              selected: {appSettings.temperatureUnit},
              onSelectionChanged: (s) => appSettings.setTemperatureUnit(s.first),
            ),
          ),
          SettingsSectionLabel(l10n.currencyFormat),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              initialValue: appSettings.currencyFormat,
              decoration: const InputDecoration(hintText: 'USD'),
              onFieldSubmitted: (value) => appSettings.setCurrencyFormat(value.trim().isEmpty ? 'USD' : value.trim()),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const _Dropdown({required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.cardBg1,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
