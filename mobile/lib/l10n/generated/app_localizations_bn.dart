// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'একটি স্থান, শহর বা ঠিকানা খুঁজুন';

  @override
  String get searchButton => 'খুঁজুন';

  @override
  String get searchRecent => 'সাম্প্রতিক';

  @override
  String get searchTryDemo => 'একটি ডেমো চেষ্টা করুন (দা লাট)';

  @override
  String get searchNoResults =>
      'কোনো ফলাফল পাওয়া যায়নি। অন্য কিছু খুঁজে দেখুন।';

  @override
  String get searchError =>
      'কিছু ভুল হয়েছে। আপনার সংযোগ পরীক্ষা করুন বা ডেমো চেষ্টা করুন।';

  @override
  String get searchChooseMatch => 'একটি স্থান বেছে নিন';

  @override
  String get graphBack => 'পেছনে';

  @override
  String get graphSettings => 'সেটিংস';

  @override
  String get graphHistory => 'ইতিহাস';

  @override
  String get graphRefresh => 'রিফ্রেশ করুন';

  @override
  String get graphRefreshAll => 'সব রিফ্রেশ করুন';

  @override
  String get graphLoading => 'তথ্য সংগ্রহ করা হচ্ছে…';

  @override
  String get graphError => 'এই স্থানটি লোড করা যায়নি।';

  @override
  String get graphRetry => 'আবার চেষ্টা করুন';

  @override
  String get detailSourceLlm => 'AI দ্বারা সারসংক্ষেপ';

  @override
  String get detailSourceApi => 'লাইভ ডেটা';

  @override
  String get detailSourceStatic => 'রেফারেন্স ডেটা';

  @override
  String get detailSourceSearch => 'অপরিশোধিত অনুসন্ধান ফলাফল';

  @override
  String get detailSourceMissingKey => 'API কী প্রয়োজন';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String detailUpdatedAt(String date) {
    return '$date এ আপডেট হয়েছে';
  }

  @override
  String get detailStale =>
      'পুরনো ক্যাশে করা ডেটা দেখানো হচ্ছে — রিফ্রেশ ব্যর্থ হয়েছে';

  @override
  String get detailSources => 'সূত্র';

  @override
  String get detailNoData => 'এখনো কোনো তথ্য উপলব্ধ নেই।';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get settingsLanguageUnits => 'ভাষা ও একক';

  @override
  String get settingsLanguageUnitsDesc =>
      'অ্যাপের ভাষা, কন্টেন্টের ভাষা, দূরত্ব/তাপমাত্রার একক';

  @override
  String get settingsApiKeys => 'API কী';

  @override
  String get settingsApiKeysDesc =>
      'আবহাওয়া ও অনুসন্ধান — স্থান/জিওকোডিং এর জন্য কী প্রয়োজন নেই';

  @override
  String get settingsAiAssistant => 'AI সহকারী';

  @override
  String get settingsAiAssistantDesc =>
      'আপনার নিজের LLM API কী, বিস্তারিত স্তর, সূত্র';

  @override
  String get settingsDataPrivacy => 'ডেটা ও গোপনীয়তা';

  @override
  String get settingsDataPrivacyDesc =>
      'ক্যাশে, ইতিহাস, অবস্থান অনুমতি, গতি, ফন্টের আকার';

  @override
  String get languageSettingsTitle => 'ভাষা ও একক';

  @override
  String get uiLanguage => 'অ্যাপের ভাষা';

  @override
  String get contentLanguage => 'কন্টেন্টের ভাষা';

  @override
  String get contentLanguageDesc =>
      'AI দ্বারা সারসংক্ষেপিত কন্টেন্টের জন্য ব্যবহৃত ভাষা — অ্যাপের ভাষার থেকে ভিন্ন হতে পারে';

  @override
  String get distanceUnit => 'দূরত্বের একক';

  @override
  String get temperatureUnit => 'তাপমাত্রার একক';

  @override
  String get currencyFormat => 'মুদ্রার বিন্যাস';

  @override
  String get km => 'কিলোমিটার';

  @override
  String get miles => 'মাইল';

  @override
  String get celsius => 'সেলসিয়াস (°C)';

  @override
  String get fahrenheit => 'ফারেনহাইট (°F)';

  @override
  String get systemDefault => 'সিস্টেম ডিফল্ট';

  @override
  String get apiKeysTitle => 'API কী';

  @override
  String get placesNoKeyNote =>
      'অনুসন্ধান, কাছাকাছি স্থান এবং নিকটতম বিমানবন্দর OpenStreetMap (Nominatim + Overpass) ব্যবহার করে — বিনামূল্যে, কোনো API কী প্রয়োজন নেই।';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API কী';

  @override
  String get weatherApiKeyDesc => 'বর্তমান আবহাওয়ার জন্য প্রয়োজনীয়।';

  @override
  String get searchApiKeyLabel => 'Tavily অনুসন্ধান API কী (ঐচ্ছিক)';

  @override
  String get searchApiKeyDesc =>
      'AI সারসংক্ষেপিত উত্তরগুলিকে বাস্তব অনুসন্ধান ফলাফলের উপর ভিত্তি করে তৈরি করে। এটি ছাড়া, AI শুধুমাত্র সাধারণ জ্ঞান থেকে উত্তর দেয়।';

  @override
  String get llmSettingsTitle => 'AI সহকারী';

  @override
  String get llmEnabled => 'AI সারসংক্ষেপ সক্রিয় করুন';

  @override
  String get llmEnabledDesc =>
      'বন্ধ থাকলে, LLM কল করার পরিবর্তে সেই আইটেমগুলি খালি রাখা হয়';

  @override
  String get byokProviderLabel => 'প্রদানকারী';

  @override
  String get byokApiKey => 'API কী';

  @override
  String get byokApiKeyHint => 'শুধুমাত্র এই ডিভাইসে নিরাপদে সংরক্ষিত';

  @override
  String get detailLevel => 'বিস্তারিত স্তর';

  @override
  String get detailLevelShort => 'সংক্ষিপ্ত';

  @override
  String get detailLevelDetailed => 'বিস্তারিত';

  @override
  String get showSources => 'সূত্র দেখান';

  @override
  String get showSourcesDesc =>
      'AI সারসংক্ষেপগুলি যে লিঙ্কের উপর ভিত্তি করে তৈরি তা দেখান';

  @override
  String get llmDisclaimer =>
      '\"AI দ্বারা সারসংক্ষেপ\" হিসাবে চিহ্নিত কন্টেন্ট ভুল হতে পারে। ভিসা, স্বাস্থ্য এবং নিরাপত্তা সম্পর্কিত তথ্য সবসময় সরকারি সূত্র থেকে যাচাই করুন।';

  @override
  String get privacySettingsTitle => 'ডেটা ও গোপনীয়তা';

  @override
  String get cacheSize => 'ক্যাশের আকার';

  @override
  String get clearCache => 'ক্যাশে মুছুন';

  @override
  String get clearCacheConfirm =>
      'এটি সমস্ত ক্যাশে করা অবস্থানের ডেটা মুছে ফেলবে। চালিয়ে যাবেন?';

  @override
  String get locationHistory => 'অবস্থানের ইতিহাস';

  @override
  String get clearHistory => 'ইতিহাস মুছুন';

  @override
  String get clearHistoryConfirm =>
      'এটি আপনার অনুসন্ধানের ইতিহাস মুছে ফেলবে। চালিয়ে যাবেন?';

  @override
  String get gpsPermission => 'আমার অবস্থান ব্যবহার করুন';

  @override
  String get gpsPermissionDesc =>
      'আপনার থেকে ১৫ কিমি এর মধ্যে স্থান খুঁজতে ব্যবহৃত হয়। আপনি সবসময় পরিবর্তে ম্যানুয়ালি অনুসন্ধান করতে পারেন।';

  @override
  String get reducedMotion => 'গতি কমান';

  @override
  String get reducedMotionDesc =>
      'নোড গ্রাফের অ্যাম্বিয়েন্ট অ্যানিমেশন বন্ধ করুন';

  @override
  String get fontSize => 'ফন্টের আকার';

  @override
  String get historyTitle => 'ইতিহাস';

  @override
  String get historyEmpty => 'এখনো কোনো স্থান অনুসন্ধান করা হয়নি।';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get cancel => 'বাতিল করুন';

  @override
  String get delete => 'মুছুন';

  @override
  String get close => 'বন্ধ করুন';

  @override
  String get groupExplore => 'অন্বেষণ';

  @override
  String get groupPractical => 'ব্যবহারিক';

  @override
  String get groupSafety => 'নিরাপত্তা ও স্বাস্থ্য';

  @override
  String get groupCulture => 'সংস্কৃতি';

  @override
  String get groupEntryStay => 'প্রবেশ ও অবস্থান';
}
