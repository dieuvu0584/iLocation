// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'חפש מקום, עיר או כתובת';

  @override
  String get searchButton => 'חיפוש';

  @override
  String get searchRecent => 'אחרונים';

  @override
  String get searchTryDemo => 'נסה הדגמה (דה לאט)';

  @override
  String get searchNoResults => 'לא נמצאו תוצאות תואמות. נסה חיפוש אחר.';

  @override
  String get searchError => 'משהו השתבש. בדוק את החיבור שלך או נסה את ההדגמה.';

  @override
  String get searchChooseMatch => 'בחר מקום';

  @override
  String get graphBack => 'חזרה';

  @override
  String get graphSettings => 'הגדרות';

  @override
  String get graphHistory => 'היסטוריה';

  @override
  String get graphRefresh => 'רענון';

  @override
  String get graphRefreshAll => 'רענן הכול';

  @override
  String get graphLoading => 'אוסף מידע…';

  @override
  String get graphError => 'לא ניתן היה לטעון את המקום הזה.';

  @override
  String get graphRetry => 'נסה שוב';

  @override
  String get detailSourceLlm => 'סוכם על ידי AI';

  @override
  String get detailSourceApi => 'נתונים חיים';

  @override
  String get detailSourceStatic => 'נתוני התייחסות';

  @override
  String get detailSourceSearch => 'תוצאות חיפוש גולמיות';

  @override
  String get detailSourceMissingKey => 'נדרש מפתח API';

  @override
  String detailUpdatedAt(String date) {
    return 'עודכן $date';
  }

  @override
  String get detailStale => 'מוצגים נתונים ישנים יותר מהמטמון — הרענון נכשל';

  @override
  String get detailSources => 'מקורות';

  @override
  String get detailNoData => 'אין עדיין מידע זמין.';

  @override
  String get settingsTitle => 'הגדרות';

  @override
  String get settingsLanguageUnits => 'שפה ויחידות';

  @override
  String get settingsLanguageUnitsDesc =>
      'שפת האפליקציה, שפת התוכן, יחידות מרחק/טמפרטורה';

  @override
  String get settingsApiKeys => 'מפתחות API';

  @override
  String get settingsApiKeysDesc =>
      'מזג אוויר וחיפוש — מקומות/קידוד גיאוגרפי אינם דורשים מפתח';

  @override
  String get settingsAiAssistant => 'עוזר AI';

  @override
  String get settingsAiAssistantDesc =>
      'מפתח API משלך ל-LLM, רמת פירוט, מקורות';

  @override
  String get settingsDataPrivacy => 'נתונים ופרטיות';

  @override
  String get settingsDataPrivacyDesc =>
      'מטמון, היסטוריה, הרשאת מיקום, תנועה, גודל גופן';

  @override
  String get languageSettingsTitle => 'שפה ויחידות';

  @override
  String get uiLanguage => 'שפת האפליקציה';

  @override
  String get contentLanguage => 'שפת התוכן';

  @override
  String get contentLanguageDesc =>
      'השפה המשמשת לתוכן שסוכם על ידי AI — עשויה להיות שונה משפת האפליקציה';

  @override
  String get distanceUnit => 'יחידת מרחק';

  @override
  String get temperatureUnit => 'יחידת טמפרטורה';

  @override
  String get currencyFormat => 'פורמט מטבע';

  @override
  String get km => 'קילומטרים';

  @override
  String get miles => 'מיילים';

  @override
  String get celsius => 'צלזיוס (°C)';

  @override
  String get fahrenheit => 'פרנהייט (°F)';

  @override
  String get systemDefault => 'ברירת מחדל של המערכת';

  @override
  String get apiKeysTitle => 'מפתחות API';

  @override
  String get placesNoKeyNote =>
      'חיפוש, מקומות בקרבת מקום והשדה התעופה הקרוב ביותר פועלים על OpenStreetMap (Nominatim + Overpass) — בחינם, ללא צורך במפתח API.';

  @override
  String get weatherApiKeyLabel => 'מפתח API של OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'נדרש עבור מזג האוויר הנוכחי.';

  @override
  String get searchApiKeyLabel => 'מפתח API לחיפוש Tavily (אופציונלי)';

  @override
  String get searchApiKeyDesc =>
      'מבסס תשובות שסוכמו על ידי AI על תוצאות חיפוש אמיתיות. בלעדיו, ה-AI עונה רק מידע כללי.';

  @override
  String get llmSettingsTitle => 'עוזר AI';

  @override
  String get llmEnabled => 'הפעל סיכומי AI';

  @override
  String get llmEnabledDesc =>
      'כשכבוי, פריטים אלו יישארו ריקים במקום לקרוא ל-LLM';

  @override
  String get byokProviderLabel => 'ספק';

  @override
  String get byokApiKey => 'מפתח API';

  @override
  String get byokApiKeyHint => 'נשמר באופן מאובטח רק במכשיר זה';

  @override
  String get detailLevel => 'רמת פירוט';

  @override
  String get detailLevelShort => 'קצר';

  @override
  String get detailLevelDetailed => 'מפורט';

  @override
  String get showSources => 'הצג מקורות';

  @override
  String get showSourcesDesc => 'הצג קישורים עליהם התבססו סיכומי AI';

  @override
  String get llmDisclaimer =>
      'תוכן המסומן כ\"סוכם על ידי AI\" עשוי להיות לא מדויק. תמיד אמת מידע על ויזה, בריאות ובטיחות ממקורות רשמיים.';

  @override
  String get privacySettingsTitle => 'נתונים ופרטיות';

  @override
  String get cacheSize => 'גודל המטמון';

  @override
  String get clearCache => 'נקה מטמון';

  @override
  String get clearCacheConfirm =>
      'פעולה זו תסיר את כל נתוני המיקום השמורים במטמון. להמשיך?';

  @override
  String get locationHistory => 'היסטוריית מיקומים';

  @override
  String get clearHistory => 'נקה היסטוריה';

  @override
  String get clearHistoryConfirm =>
      'פעולה זו תסיר את היסטוריית החיפוש שלך. להמשיך?';

  @override
  String get gpsPermission => 'השתמש במיקום שלי';

  @override
  String get gpsPermissionDesc =>
      'משמש למציאת מקומות ברדיוס של 15 ק\"מ ממך. תמיד תוכל לחפש ידנית במקום זאת.';

  @override
  String get reducedMotion => 'הפחת תנועה';

  @override
  String get reducedMotionDesc => 'כבה אנימציית רקע בגרף הצמתים';

  @override
  String get fontSize => 'גודל גופן';

  @override
  String get historyTitle => 'היסטוריה';

  @override
  String get historyEmpty => 'עדיין לא חופשו מקומות.';

  @override
  String get save => 'שמור';

  @override
  String get cancel => 'ביטול';

  @override
  String get delete => 'מחק';

  @override
  String get close => 'סגור';

  @override
  String get groupExplore => 'גלה';

  @override
  String get groupPractical => 'מעשי';

  @override
  String get groupSafety => 'בטיחות ובריאות';

  @override
  String get groupCulture => 'תרבות';

  @override
  String get groupEntryStay => 'כניסה ושהות';
}
