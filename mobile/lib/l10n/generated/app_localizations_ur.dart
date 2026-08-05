// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'کوئی جگہ، شہر یا پتا تلاش کریں';

  @override
  String get searchButton => 'تلاش کریں';

  @override
  String get searchRecent => 'حالیہ';

  @override
  String get searchTryDemo => 'ڈیمو آزمائیں (دا لاٹ)';

  @override
  String get searchNoResults => 'کوئی نتیجہ نہیں ملا۔ کوئی مختلف تلاش آزمائیں۔';

  @override
  String get searchError =>
      'کچھ غلط ہو گیا۔ اپنا کنکشن چیک کریں یا ڈیمو آزمائیں۔';

  @override
  String get searchChooseMatch => 'ایک جگہ منتخب کریں';

  @override
  String get graphBack => 'واپس';

  @override
  String get graphSettings => 'ترتیبات';

  @override
  String get graphHistory => 'تاریخ';

  @override
  String get graphRefresh => 'ریفریش کریں';

  @override
  String get graphRefreshAll => 'سب ریفریش کریں';

  @override
  String get graphLoading => 'معلومات جمع کی جا رہی ہیں…';

  @override
  String get graphError => 'یہ جگہ لوڈ نہیں ہو سکی۔';

  @override
  String get graphRetry => 'دوبارہ کوشش کریں';

  @override
  String get detailSourceLlm => 'AI کا خلاصہ';

  @override
  String get detailSourceApi => 'براہ راست ڈیٹا';

  @override
  String get detailSourceStatic => 'حوالہ ڈیٹا';

  @override
  String get detailSourceSearch => 'خام تلاش کے نتائج';

  @override
  String get detailSourceMissingKey => 'API کلید درکار ہے';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String detailUpdatedAt(String date) {
    return '$date کو اپ ڈیٹ کیا گیا';
  }

  @override
  String get detailStale =>
      'پرانا کیش شدہ ڈیٹا دکھایا جا رہا ہے — ریفریش ناکام ہوا';

  @override
  String get detailSources => 'ذرائع';

  @override
  String get detailNoData => 'ابھی تک کوئی معلومات دستیاب نہیں۔';

  @override
  String get settingsTitle => 'ترتیبات';

  @override
  String get settingsLanguageUnits => 'زبان اور اکائیاں';

  @override
  String get settingsLanguageUnitsDesc =>
      'ایپ کی زبان، مواد کی زبان، فاصلے/درجہ حرارت کی اکائیاں';

  @override
  String get settingsApiKeys => 'API کلیدیں';

  @override
  String get settingsApiKeysDesc =>
      'موسم اور تلاش — مقامات/جیو کوڈنگ کو کلید کی ضرورت نہیں';

  @override
  String get settingsAiAssistant => 'AI معاون';

  @override
  String get settingsAiAssistantDesc =>
      'آپ کی اپنی LLM API کلید، تفصیل کی سطح، ذرائع';

  @override
  String get settingsDataPrivacy => 'ڈیٹا اور رازداری';

  @override
  String get settingsDataPrivacyDesc =>
      'کیش، تاریخ، مقام کی اجازت، حرکت، فونٹ کا سائز';

  @override
  String get languageSettingsTitle => 'زبان اور اکائیاں';

  @override
  String get uiLanguage => 'ایپ کی زبان';

  @override
  String get contentLanguage => 'مواد کی زبان';

  @override
  String get contentLanguageDesc =>
      'AI کے خلاصہ کردہ مواد کے لیے استعمال ہونے والی زبان — ایپ کی زبان سے مختلف ہو سکتی ہے';

  @override
  String get distanceUnit => 'فاصلے کی اکائی';

  @override
  String get temperatureUnit => 'درجہ حرارت کی اکائی';

  @override
  String get currencyFormat => 'کرنسی فارمیٹ';

  @override
  String get km => 'کلومیٹر';

  @override
  String get miles => 'میل';

  @override
  String get celsius => 'سیلسیس (°C)';

  @override
  String get fahrenheit => 'فارن ہائیٹ (°F)';

  @override
  String get systemDefault => 'سسٹم ڈیفالٹ';

  @override
  String get apiKeysTitle => 'API کلیدیں';

  @override
  String get placesNoKeyNote =>
      'تلاش، قریبی مقامات اور قریب ترین ہوائی اڈہ OpenStreetMap (Nominatim + Overpass) پر چلتے ہیں — مفت، کسی API کلید کی ضرورت نہیں۔';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API کلید';

  @override
  String get weatherApiKeyDesc => 'موجودہ موسم کے لیے ضروری۔';

  @override
  String get searchApiKeyLabel => 'Tavily تلاش API کلید (اختیاری)';

  @override
  String get searchApiKeyDesc =>
      'AI کے خلاصہ شدہ جوابات کو حقیقی تلاش کے نتائج پر مبنی کرتا ہے۔ اس کے بغیر، AI صرف عمومی علم سے جواب دیتا ہے۔';

  @override
  String get llmSettingsTitle => 'AI معاون';

  @override
  String get llmEnabled => 'AI خلاصے فعال کریں';

  @override
  String get llmEnabledDesc =>
      'بند ہونے پر، یہ آئٹمز LLM کو کال کرنے کے بجائے خالی رہ جاتے ہیں';

  @override
  String get byokProviderLabel => 'فراہم کنندہ';

  @override
  String get byokApiKey => 'API کلید';

  @override
  String get byokApiKeyHint => 'صرف اس ڈیوائس پر محفوظ طریقے سے محفوظ';

  @override
  String get detailLevel => 'تفصیل کی سطح';

  @override
  String get detailLevelShort => 'مختصر';

  @override
  String get detailLevelDetailed => 'تفصیلی';

  @override
  String get showSources => 'ذرائع دکھائیں';

  @override
  String get showSourcesDesc => 'وہ لنکس دکھائیں جن پر AI خلاصے مبنی تھے';

  @override
  String get llmDisclaimer =>
      '\"AI کا خلاصہ\" کے طور پر نشان زد مواد غلط ہو سکتا ہے۔ ویزا، صحت اور حفاظت کی معلومات کی ہمیشہ سرکاری ذرائع سے تصدیق کریں۔';

  @override
  String get privacySettingsTitle => 'ڈیٹا اور رازداری';

  @override
  String get cacheSize => 'کیش کا سائز';

  @override
  String get clearCache => 'کیش صاف کریں';

  @override
  String get clearCacheConfirm =>
      'اس سے تمام کیش شدہ مقام کا ڈیٹا ہٹ جائے گا۔ جاری رکھیں؟';

  @override
  String get locationHistory => 'مقام کی تاریخ';

  @override
  String get clearHistory => 'تاریخ صاف کریں';

  @override
  String get clearHistoryConfirm =>
      'اس سے آپ کی تلاش کی تاریخ ہٹ جائے گی۔ جاری رکھیں؟';

  @override
  String get gpsPermission => 'میرا مقام استعمال کریں';

  @override
  String get gpsPermissionDesc =>
      'آپ سے 15 کلومیٹر کے دائرے میں مقامات تلاش کرنے کے لیے استعمال ہوتا ہے۔ آپ ہمیشہ اس کے بجائے دستی طور پر تلاش کر سکتے ہیں۔';

  @override
  String get reducedMotion => 'حرکت کم کریں';

  @override
  String get reducedMotionDesc => 'نوڈ گراف میں ماحولیاتی اینیمیشن بند کریں';

  @override
  String get fontSize => 'فونٹ کا سائز';

  @override
  String get historyTitle => 'تاریخ';

  @override
  String get historyEmpty => 'ابھی تک کوئی مقام تلاش نہیں کیا گیا۔';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get delete => 'حذف کریں';

  @override
  String get close => 'بند کریں';

  @override
  String get groupExplore => 'دریافت کریں';

  @override
  String get groupPractical => 'عملی';

  @override
  String get groupSafety => 'حفاظت اور صحت';

  @override
  String get groupCulture => 'ثقافت';

  @override
  String get groupEntryStay => 'داخلہ اور قیام';
}
