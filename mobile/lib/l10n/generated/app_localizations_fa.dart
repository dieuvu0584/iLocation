// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'جستجوی یک مکان، شهر یا آدرس';

  @override
  String get searchButton => 'جستجو';

  @override
  String get searchRecent => 'اخیر';

  @override
  String get searchTryDemo => 'امتحان نسخه نمایشی (دالات)';

  @override
  String get searchNoResults =>
      'نتیجه‌ای یافت نشد. جستجوی دیگری را امتحان کنید.';

  @override
  String get searchError =>
      'مشکلی پیش آمد. اتصال خود را بررسی کنید یا نسخه نمایشی را امتحان کنید.';

  @override
  String get searchChooseMatch => 'یک مکان انتخاب کنید';

  @override
  String get graphBack => 'بازگشت';

  @override
  String get graphSettings => 'تنظیمات';

  @override
  String get graphHistory => 'تاریخچه';

  @override
  String get graphRefresh => 'به‌روزرسانی';

  @override
  String get graphRefreshAll => 'به‌روزرسانی همه';

  @override
  String get graphLoading => 'در حال جمع‌آوری اطلاعات…';

  @override
  String get graphError => 'این مکان بارگذاری نشد.';

  @override
  String get graphRetry => 'تلاش دوباره';

  @override
  String get detailSourceLlm => 'خلاصه‌شده توسط هوش مصنوعی';

  @override
  String get detailSourceApi => 'داده زنده';

  @override
  String get detailSourceStatic => 'داده مرجع';

  @override
  String get detailSourceSearch => 'نتایج خام جستجو';

  @override
  String get detailSourceMissingKey => 'نیاز به کلید API';

  @override
  String detailUpdatedAt(String date) {
    return 'به‌روزرسانی شده $date';
  }

  @override
  String get detailStale =>
      'داده‌های ذخیره‌شده قدیمی‌تر نمایش داده می‌شود — به‌روزرسانی ناموفق بود';

  @override
  String get detailSources => 'منابع';

  @override
  String get detailNoData => 'هنوز اطلاعاتی در دسترس نیست.';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get settingsLanguageUnits => 'زبان و واحدها';

  @override
  String get settingsLanguageUnitsDesc =>
      'زبان رابط کاربری، زبان محتوا، واحدهای فاصله/دما';

  @override
  String get settingsApiKeys => 'کلیدهای API';

  @override
  String get settingsApiKeysDesc =>
      'آب‌وهوا و جستجو — مکان‌ها/جغرافیانگاری نیازی به کلید ندارند';

  @override
  String get settingsAiAssistant => 'دستیار هوش مصنوعی';

  @override
  String get settingsAiAssistantDesc =>
      'کلید API مدل زبانی خودتان، سطح جزئیات، منابع';

  @override
  String get settingsDataPrivacy => 'داده و حریم خصوصی';

  @override
  String get settingsDataPrivacyDesc =>
      'حافظه پنهان، تاریخچه، مجوز مکان، حرکت، اندازه فونت';

  @override
  String get languageSettingsTitle => 'زبان و واحدها';

  @override
  String get uiLanguage => 'زبان برنامه';

  @override
  String get contentLanguage => 'زبان محتوا';

  @override
  String get contentLanguageDesc =>
      'زبان استفاده‌شده برای محتوای خلاصه‌شده توسط هوش مصنوعی — می‌تواند با زبان برنامه متفاوت باشد';

  @override
  String get distanceUnit => 'واحد فاصله';

  @override
  String get temperatureUnit => 'واحد دما';

  @override
  String get currencyFormat => 'قالب ارز';

  @override
  String get km => 'کیلومتر';

  @override
  String get miles => 'مایل';

  @override
  String get celsius => 'سلسیوس (°C)';

  @override
  String get fahrenheit => 'فارنهایت (°F)';

  @override
  String get systemDefault => 'پیش‌فرض سیستم';

  @override
  String get apiKeysTitle => 'کلیدهای API';

  @override
  String get placesNoKeyNote =>
      'جستجو، مکان‌های نزدیک و نزدیک‌ترین فرودگاه از طریق OpenStreetMap (Nominatim + Overpass) کار می‌کنند — رایگان، بدون نیاز به کلید API.';

  @override
  String get weatherApiKeyLabel => 'کلید API نقشه آب‌وهوا (OpenWeatherMap)';

  @override
  String get weatherApiKeyDesc => 'برای نمایش آب‌وهوای فعلی لازم است.';

  @override
  String get searchApiKeyLabel => 'کلید API جستجوی Tavily (اختیاری)';

  @override
  String get searchApiKeyDesc =>
      'پاسخ‌های خلاصه‌شده هوش مصنوعی را بر اساس نتایج واقعی جستجو استوار می‌کند. بدون آن، هوش مصنوعی فقط از دانش عمومی پاسخ می‌دهد.';

  @override
  String get llmSettingsTitle => 'دستیار هوش مصنوعی';

  @override
  String get llmEnabled => 'فعال‌سازی خلاصه‌های هوش مصنوعی';

  @override
  String get llmEnabledDesc =>
      'وقتی خاموش باشد، این موارد به‌جای فراخوانی مدل زبانی، خالی باقی می‌مانند';

  @override
  String get byokProviderLabel => 'ارائه‌دهنده';

  @override
  String get byokApiKey => 'کلید API';

  @override
  String get byokApiKeyHint => 'فقط به‌صورت امن روی همین دستگاه ذخیره می‌شود';

  @override
  String get detailLevel => 'سطح جزئیات';

  @override
  String get detailLevelShort => 'خلاصه';

  @override
  String get detailLevelDetailed => 'با جزئیات';

  @override
  String get showSources => 'نمایش منابع';

  @override
  String get showSourcesDesc =>
      'نمایش لینک‌هایی که خلاصه‌های هوش مصنوعی بر اساس آن‌ها بوده‌اند';

  @override
  String get llmDisclaimer =>
      'محتوای علامت‌گذاری‌شده با «خلاصه‌شده توسط هوش مصنوعی» ممکن است نادرست باشد. همیشه اطلاعات ویزا، سلامت و ایمنی را از منابع رسمی بررسی کنید.';

  @override
  String get privacySettingsTitle => 'داده و حریم خصوصی';

  @override
  String get cacheSize => 'حجم حافظه پنهان';

  @override
  String get clearCache => 'پاک کردن حافظه پنهان';

  @override
  String get clearCacheConfirm =>
      'این کار تمام داده‌های مکانی ذخیره‌شده را حذف می‌کند. ادامه می‌دهید؟';

  @override
  String get locationHistory => 'تاریخچه مکان‌ها';

  @override
  String get clearHistory => 'پاک کردن تاریخچه';

  @override
  String get clearHistoryConfirm =>
      'این کار تاریخچه جستجوی شما را حذف می‌کند. ادامه می‌دهید؟';

  @override
  String get gpsPermission => 'استفاده از موقعیت من';

  @override
  String get gpsPermissionDesc =>
      'برای یافتن مکان‌ها در شعاع ۱۵ کیلومتری شما استفاده می‌شود. همیشه می‌توانید به‌جای آن به‌صورت دستی جستجو کنید.';

  @override
  String get reducedMotion => 'کاهش انیمیشن';

  @override
  String get reducedMotionDesc => 'خاموش کردن انیمیشن محیطی در نمودار گره‌ها';

  @override
  String get fontSize => 'اندازه فونت';

  @override
  String get historyTitle => 'تاریخچه';

  @override
  String get historyEmpty => 'هنوز مکانی جستجو نشده است.';

  @override
  String get save => 'ذخیره';

  @override
  String get cancel => 'لغو';

  @override
  String get delete => 'حذف';

  @override
  String get close => 'بستن';

  @override
  String get groupExplore => 'کاوش';

  @override
  String get groupPractical => 'عملی';

  @override
  String get groupSafety => 'ایمنی و سلامت';

  @override
  String get groupCulture => 'فرهنگ';

  @override
  String get groupEntryStay => 'ورود و اقامت';
}
