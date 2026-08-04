import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Explorer'**
  String get appTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search a place, city, or address'**
  String get searchHint;

  /// No description provided for @searchButton.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchButton;

  /// No description provided for @searchRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get searchRecent;

  /// No description provided for @searchTryDemo.
  ///
  /// In en, this message translates to:
  /// **'Try a demo (Da Lat)'**
  String get searchTryDemo;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No matches found. Try a different search.'**
  String get searchNoResults;

  /// No description provided for @searchError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Check your connection or try the demo.'**
  String get searchError;

  /// No description provided for @searchChooseMatch.
  ///
  /// In en, this message translates to:
  /// **'Choose a match'**
  String get searchChooseMatch;

  /// No description provided for @graphBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get graphBack;

  /// No description provided for @graphSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get graphSettings;

  /// No description provided for @graphHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get graphHistory;

  /// No description provided for @graphRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get graphRefresh;

  /// No description provided for @graphRefreshAll.
  ///
  /// In en, this message translates to:
  /// **'Refresh all'**
  String get graphRefreshAll;

  /// No description provided for @graphLoading.
  ///
  /// In en, this message translates to:
  /// **'Gathering information…'**
  String get graphLoading;

  /// No description provided for @graphError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load this location.'**
  String get graphError;

  /// No description provided for @graphRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get graphRetry;

  /// No description provided for @detailSourceLlm.
  ///
  /// In en, this message translates to:
  /// **'AI-summarized'**
  String get detailSourceLlm;

  /// No description provided for @detailSourceApi.
  ///
  /// In en, this message translates to:
  /// **'Live data'**
  String get detailSourceApi;

  /// No description provided for @detailSourceStatic.
  ///
  /// In en, this message translates to:
  /// **'Reference data'**
  String get detailSourceStatic;

  /// No description provided for @detailSourceSearch.
  ///
  /// In en, this message translates to:
  /// **'Raw search results'**
  String get detailSourceSearch;

  /// No description provided for @detailSourceMissingKey.
  ///
  /// In en, this message translates to:
  /// **'Needs API key'**
  String get detailSourceMissingKey;

  /// No description provided for @detailUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated {date}'**
  String detailUpdatedAt(String date);

  /// No description provided for @detailStale.
  ///
  /// In en, this message translates to:
  /// **'Showing older cached data — refresh failed'**
  String get detailStale;

  /// No description provided for @detailSources.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get detailSources;

  /// No description provided for @detailNoData.
  ///
  /// In en, this message translates to:
  /// **'No information available yet.'**
  String get detailNoData;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguageUnits.
  ///
  /// In en, this message translates to:
  /// **'Language & Units'**
  String get settingsLanguageUnits;

  /// No description provided for @settingsLanguageUnitsDesc.
  ///
  /// In en, this message translates to:
  /// **'UI language, content language, distance/temperature units'**
  String get settingsLanguageUnitsDesc;

  /// No description provided for @settingsApiKeys.
  ///
  /// In en, this message translates to:
  /// **'API Keys'**
  String get settingsApiKeys;

  /// No description provided for @settingsApiKeysDesc.
  ///
  /// In en, this message translates to:
  /// **'Weather and search — places/geocoding needs no key'**
  String get settingsApiKeysDesc;

  /// No description provided for @settingsAiAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get settingsAiAssistant;

  /// No description provided for @settingsAiAssistantDesc.
  ///
  /// In en, this message translates to:
  /// **'Your own LLM API key, detail level, sources'**
  String get settingsAiAssistantDesc;

  /// No description provided for @settingsDataPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Data & Privacy'**
  String get settingsDataPrivacy;

  /// No description provided for @settingsDataPrivacyDesc.
  ///
  /// In en, this message translates to:
  /// **'Cache, history, location permission, motion, font size'**
  String get settingsDataPrivacyDesc;

  /// No description provided for @languageSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Language & Units'**
  String get languageSettingsTitle;

  /// No description provided for @uiLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get uiLanguage;

  /// No description provided for @contentLanguage.
  ///
  /// In en, this message translates to:
  /// **'Content language'**
  String get contentLanguage;

  /// No description provided for @contentLanguageDesc.
  ///
  /// In en, this message translates to:
  /// **'Language used for AI-summarized content — can differ from the app language'**
  String get contentLanguageDesc;

  /// No description provided for @distanceUnit.
  ///
  /// In en, this message translates to:
  /// **'Distance unit'**
  String get distanceUnit;

  /// No description provided for @temperatureUnit.
  ///
  /// In en, this message translates to:
  /// **'Temperature unit'**
  String get temperatureUnit;

  /// No description provided for @currencyFormat.
  ///
  /// In en, this message translates to:
  /// **'Currency format'**
  String get currencyFormat;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'Kilometers'**
  String get km;

  /// No description provided for @miles.
  ///
  /// In en, this message translates to:
  /// **'Miles'**
  String get miles;

  /// No description provided for @celsius.
  ///
  /// In en, this message translates to:
  /// **'Celsius (°C)'**
  String get celsius;

  /// No description provided for @fahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Fahrenheit (°F)'**
  String get fahrenheit;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @apiKeysTitle.
  ///
  /// In en, this message translates to:
  /// **'API Keys'**
  String get apiKeysTitle;

  /// No description provided for @placesNoKeyNote.
  ///
  /// In en, this message translates to:
  /// **'Search, nearby places, and the nearest airport run on OpenStreetMap (Nominatim + Overpass) — free, no API key needed.'**
  String get placesNoKeyNote;

  /// No description provided for @weatherApiKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'OpenWeatherMap API key'**
  String get weatherApiKeyLabel;

  /// No description provided for @weatherApiKeyDesc.
  ///
  /// In en, this message translates to:
  /// **'Needed for the current weather.'**
  String get weatherApiKeyDesc;

  /// No description provided for @searchApiKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'Tavily search API key (optional)'**
  String get searchApiKeyLabel;

  /// No description provided for @searchApiKeyDesc.
  ///
  /// In en, this message translates to:
  /// **'Grounds AI-summarized answers in real search results. Without it, the AI answers from general knowledge only.'**
  String get searchApiKeyDesc;

  /// No description provided for @llmSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get llmSettingsTitle;

  /// No description provided for @llmEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enable AI summaries'**
  String get llmEnabled;

  /// No description provided for @llmEnabledDesc.
  ///
  /// In en, this message translates to:
  /// **'When off, those items are simply left blank instead of calling an LLM'**
  String get llmEnabledDesc;

  /// No description provided for @byokProviderLabel.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get byokProviderLabel;

  /// No description provided for @byokApiKey.
  ///
  /// In en, this message translates to:
  /// **'API key'**
  String get byokApiKey;

  /// No description provided for @byokApiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Stored securely on this device only'**
  String get byokApiKeyHint;

  /// No description provided for @detailLevel.
  ///
  /// In en, this message translates to:
  /// **'Detail level'**
  String get detailLevel;

  /// No description provided for @detailLevelShort.
  ///
  /// In en, this message translates to:
  /// **'Short'**
  String get detailLevelShort;

  /// No description provided for @detailLevelDetailed.
  ///
  /// In en, this message translates to:
  /// **'Detailed'**
  String get detailLevelDetailed;

  /// No description provided for @showSources.
  ///
  /// In en, this message translates to:
  /// **'Show sources'**
  String get showSources;

  /// No description provided for @showSourcesDesc.
  ///
  /// In en, this message translates to:
  /// **'Display links AI summaries were based on'**
  String get showSourcesDesc;

  /// No description provided for @llmDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Content marked \"AI-summarized\" may be inaccurate. Always verify visa, health, and safety information with official sources.'**
  String get llmDisclaimer;

  /// No description provided for @privacySettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Data & Privacy'**
  String get privacySettingsTitle;

  /// No description provided for @cacheSize.
  ///
  /// In en, this message translates to:
  /// **'Cache size'**
  String get cacheSize;

  /// No description provided for @clearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get clearCache;

  /// No description provided for @clearCacheConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will remove all cached location data. Continue?'**
  String get clearCacheConfirm;

  /// No description provided for @locationHistory.
  ///
  /// In en, this message translates to:
  /// **'Location history'**
  String get locationHistory;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get clearHistory;

  /// No description provided for @clearHistoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will remove your search history. Continue?'**
  String get clearHistoryConfirm;

  /// No description provided for @gpsPermission.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get gpsPermission;

  /// No description provided for @gpsPermissionDesc.
  ///
  /// In en, this message translates to:
  /// **'Used to find places within 15km of you. You can always search manually instead.'**
  String get gpsPermissionDesc;

  /// No description provided for @reducedMotion.
  ///
  /// In en, this message translates to:
  /// **'Reduce motion'**
  String get reducedMotion;

  /// No description provided for @reducedMotionDesc.
  ///
  /// In en, this message translates to:
  /// **'Turn off ambient animation in the node graph'**
  String get reducedMotionDesc;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font size'**
  String get fontSize;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No locations looked up yet.'**
  String get historyEmpty;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @groupExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get groupExplore;

  /// No description provided for @groupPractical.
  ///
  /// In en, this message translates to:
  /// **'Practical'**
  String get groupPractical;

  /// No description provided for @groupSafety.
  ///
  /// In en, this message translates to:
  /// **'Safety & Health'**
  String get groupSafety;

  /// No description provided for @groupCulture.
  ///
  /// In en, this message translates to:
  /// **'Culture'**
  String get groupCulture;

  /// No description provided for @groupEntryStay.
  ///
  /// In en, this message translates to:
  /// **'Entry & Stay'**
  String get groupEntryStay;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
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
      'that was used.');
}
