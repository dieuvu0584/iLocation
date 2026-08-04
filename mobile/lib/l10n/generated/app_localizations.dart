// GENERATED CODE — hand-authored to match the output of `flutter gen-l10n`
// (see ../../../l10n.yaml and the ARB files in ../). Normally this file is
// produced automatically by the Flutter SDK from lib/l10n/app_en.arb and
// app_vi.arb; it's checked in here because this environment has no Flutter
// SDK to run codegen with. If you add/change a key, update the matching ARB
// file AND app_localizations_en.dart / app_localizations_vi.dart together,
// or regenerate all three with `flutter gen-l10n` once the SDK is available.
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale);

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  String get appTitle;
  String get searchHint;
  String get searchButton;
  String get searchRecent;
  String get searchTryDemo;
  String get searchNoResults;
  String get searchError;
  String get searchChooseMatch;

  String get graphBack;
  String get graphSettings;
  String get graphHistory;
  String get graphRefresh;
  String get graphRefreshAll;
  String get graphLoading;
  String get graphError;
  String get graphRetry;

  String get detailSourceLlm;
  String get detailSourceApi;
  String get detailSourceStatic;
  String get detailSourceSearch;
  String detailUpdatedAt(String date);
  String get detailStale;
  String get detailSources;
  String get detailNoData;

  String get settingsTitle;
  String get settingsLanguageUnits;
  String get settingsLanguageUnitsDesc;
  String get settingsAiAssistant;
  String get settingsAiAssistantDesc;
  String get settingsDataPrivacy;
  String get settingsDataPrivacyDesc;

  String get languageSettingsTitle;
  String get uiLanguage;
  String get contentLanguage;
  String get contentLanguageDesc;
  String get distanceUnit;
  String get temperatureUnit;
  String get currencyFormat;
  String get km;
  String get miles;
  String get celsius;
  String get fahrenheit;
  String get systemDefault;

  String get llmSettingsTitle;
  String get llmEnabled;
  String get llmEnabledDesc;
  String get providerMode;
  String get providerFree;
  String get providerByok;
  String freeTierUsage(int used, int limit);
  String get freeTierWarning;
  String get byokProviderLabel;
  String get byokApiKey;
  String get byokApiKeyHint;
  String get fallbackEnabled;
  String get fallbackEnabledDesc;
  String get detailLevel;
  String get detailLevelShort;
  String get detailLevelDetailed;
  String get showSources;
  String get showSourcesDesc;
  String get llmDisclaimer;

  String get privacySettingsTitle;
  String get cacheSize;
  String get clearCache;
  String get clearCacheConfirm;
  String get locationHistory;
  String get clearHistory;
  String get clearHistoryConfirm;
  String get gpsPermission;
  String get gpsPermissionDesc;
  String get reducedMotion;
  String get reducedMotionDesc;
  String get fontSize;

  String get historyTitle;
  String get historyEmpty;

  String get save;
  String get cancel;
  String get delete;
  String get close;

  String get groupExplore;
  String get groupPractical;
  String get groupSafety;
  String get groupCulture;
  String get groupEntryStay;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
