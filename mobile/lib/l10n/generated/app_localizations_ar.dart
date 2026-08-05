// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'ابحث عن مكان أو مدينة أو عنوان';

  @override
  String get searchButton => 'بحث';

  @override
  String get searchRecent => 'الأخيرة';

  @override
  String get searchTryDemo => 'جرّب عرضًا توضيحيًا (دالات)';

  @override
  String get searchNoResults =>
      'لم يتم العثور على نتائج مطابقة. جرّب بحثًا مختلفًا.';

  @override
  String get searchError =>
      'حدث خطأ ما. تحقق من اتصالك أو جرّب العرض التوضيحي.';

  @override
  String get searchChooseMatch => 'اختر مكانًا';

  @override
  String get graphBack => 'رجوع';

  @override
  String get graphSettings => 'الإعدادات';

  @override
  String get graphHistory => 'السجل';

  @override
  String get graphRefresh => 'تحديث';

  @override
  String get graphRefreshAll => 'تحديث الكل';

  @override
  String get graphLoading => 'جارٍ جمع المعلومات…';

  @override
  String get graphError => 'تعذّر تحميل هذا الموقع.';

  @override
  String get graphRetry => 'إعادة المحاولة';

  @override
  String get detailSourceLlm => 'ملخّص بالذكاء الاصطناعي';

  @override
  String get detailSourceApi => 'بيانات مباشرة';

  @override
  String get detailSourceStatic => 'بيانات مرجعية';

  @override
  String get detailSourceSearch => 'نتائج بحث أولية';

  @override
  String get detailSourceMissingKey => 'يلزم مفتاح API';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'تم التحديث $date';
  }

  @override
  String get detailStale => 'تُعرض بيانات مخزّنة مؤقتًا أقدم — فشل التحديث';

  @override
  String get detailSources => 'المصادر';

  @override
  String get detailNoData => 'لا تتوفر معلومات بعد.';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsLanguageUnits => 'اللغة والوحدات';

  @override
  String get settingsLanguageUnitsDesc =>
      'لغة الواجهة، لغة المحتوى، وحدات المسافة/درجة الحرارة';

  @override
  String get settingsApiKeys => 'مفاتيح API';

  @override
  String get settingsApiKeysDesc =>
      'الطقس والبحث — الأماكن/الترميز الجغرافي لا يحتاجان إلى مفتاح';

  @override
  String get settingsAiAssistant => 'مساعد الذكاء الاصطناعي';

  @override
  String get settingsAiAssistantDesc =>
      'مفتاح API الخاص بك لنموذج اللغة، مستوى التفصيل، المصادر';

  @override
  String get settingsDataPrivacy => 'البيانات والخصوصية';

  @override
  String get settingsDataPrivacyDesc =>
      'التخزين المؤقت، السجل، إذن الموقع، الحركة، حجم الخط';

  @override
  String get languageSettingsTitle => 'اللغة والوحدات';

  @override
  String get uiLanguage => 'لغة التطبيق';

  @override
  String get contentLanguage => 'لغة المحتوى';

  @override
  String get contentLanguageDesc =>
      'اللغة المستخدمة للمحتوى الملخّص بالذكاء الاصطناعي — قد تختلف عن لغة التطبيق';

  @override
  String get distanceUnit => 'وحدة المسافة';

  @override
  String get temperatureUnit => 'وحدة درجة الحرارة';

  @override
  String get currencyFormat => 'تنسيق العملة';

  @override
  String get km => 'كيلومترات';

  @override
  String get miles => 'أميال';

  @override
  String get celsius => 'مئوية (°C)';

  @override
  String get fahrenheit => 'فهرنهايت (°F)';

  @override
  String get systemDefault => 'افتراضي النظام';

  @override
  String get apiKeysTitle => 'مفاتيح API';

  @override
  String get placesNoKeyNote =>
      'يعمل البحث والأماكن القريبة وأقرب مطار عبر OpenStreetMap (Nominatim + Overpass) — مجانًا، دون الحاجة إلى مفتاح API.';

  @override
  String get weatherApiKeyLabel => 'مفتاح API لـ OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'مطلوب لعرض الطقس الحالي.';

  @override
  String get searchApiKeyLabel => 'مفتاح API للبحث عبر Tavily (اختياري)';

  @override
  String get searchApiKeyDesc =>
      'يستند الردود الملخّصة بالذكاء الاصطناعي إلى نتائج بحث حقيقية. بدونه، يجيب الذكاء الاصطناعي فقط من معرفته العامة.';

  @override
  String get llmSettingsTitle => 'مساعد الذكاء الاصطناعي';

  @override
  String get llmEnabled => 'تفعيل الملخصات بالذكاء الاصطناعي';

  @override
  String get llmEnabledDesc =>
      'عند التعطيل، تبقى هذه العناصر فارغة بدلاً من استدعاء نموذج اللغة';

  @override
  String get byokProviderLabel => 'المزوّد';

  @override
  String get byokApiKey => 'مفتاح API';

  @override
  String get byokApiKeyHint => 'يُخزَّن بأمان على هذا الجهاز فقط';

  @override
  String get detailLevel => 'مستوى التفصيل';

  @override
  String get detailLevelShort => 'موجز';

  @override
  String get detailLevelDetailed => 'مفصّل';

  @override
  String get showSources => 'إظهار المصادر';

  @override
  String get showSourcesDesc => 'عرض الروابط التي استندت إليها الملخصات';

  @override
  String get llmDisclaimer =>
      'قد يكون المحتوى المُعلَّم بـ \"ملخّص بالذكاء الاصطناعي\" غير دقيق. تحقق دائمًا من معلومات التأشيرة والصحة والسلامة من مصادر رسمية.';

  @override
  String get privacySettingsTitle => 'البيانات والخصوصية';

  @override
  String get cacheSize => 'حجم التخزين المؤقت';

  @override
  String get clearCache => 'مسح التخزين المؤقت';

  @override
  String get clearCacheConfirm =>
      'سيؤدي هذا إلى إزالة جميع بيانات الأماكن المخزّنة مؤقتًا. المتابعة؟';

  @override
  String get locationHistory => 'سجل الأماكن';

  @override
  String get clearHistory => 'مسح السجل';

  @override
  String get clearHistoryConfirm =>
      'سيؤدي هذا إلى إزالة سجل البحث الخاص بك. المتابعة؟';

  @override
  String get gpsPermission => 'استخدام موقعي';

  @override
  String get gpsPermissionDesc =>
      'يُستخدم للعثور على أماكن ضمن 15 كم منك. يمكنك دائمًا البحث يدويًا بدلاً من ذلك.';

  @override
  String get reducedMotion => 'تقليل الحركة';

  @override
  String get reducedMotionDesc => 'إيقاف الحركة المحيطية في مخطط العُقد';

  @override
  String get fontSize => 'حجم الخط';

  @override
  String get historyTitle => 'السجل';

  @override
  String get historyEmpty => 'لم يتم البحث عن أي مكان بعد.';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get close => 'إغلاق';

  @override
  String get groupExplore => 'استكشاف';

  @override
  String get groupPractical => 'عملي';

  @override
  String get groupSafety => 'السلامة والصحة';

  @override
  String get groupCulture => 'الثقافة';

  @override
  String get groupEntryStay => 'الدخول والإقامة';
}
