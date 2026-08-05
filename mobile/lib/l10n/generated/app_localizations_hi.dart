// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'कोई जगह, शहर या पता खोजें';

  @override
  String get searchButton => 'खोजें';

  @override
  String get searchRecent => 'हाल की खोजें';

  @override
  String get searchTryDemo => 'डेमो आज़माएँ (दा लाट)';

  @override
  String get searchNoResults => 'कोई मिलान नहीं मिला। कोई अलग खोज आज़माएँ।';

  @override
  String get searchError =>
      'कुछ गड़बड़ हो गई। अपना कनेक्शन जाँचें या डेमो आज़माएँ।';

  @override
  String get searchChooseMatch => 'एक जगह चुनें';

  @override
  String get graphBack => 'वापस';

  @override
  String get graphSettings => 'सेटिंग्स';

  @override
  String get graphHistory => 'इतिहास';

  @override
  String get graphRefresh => 'रीफ़्रेश करें';

  @override
  String get graphRefreshAll => 'सब रीफ़्रेश करें';

  @override
  String get graphLoading => 'जानकारी एकत्र की जा रही है…';

  @override
  String get graphError => 'इस जगह को लोड नहीं किया जा सका।';

  @override
  String get graphRetry => 'फिर से कोशिश करें';

  @override
  String get detailSourceLlm => 'AI द्वारा सारांशित';

  @override
  String get detailSourceApi => 'लाइव डेटा';

  @override
  String get detailSourceStatic => 'संदर्भ डेटा';

  @override
  String get detailSourceSearch => 'कच्चे खोज परिणाम';

  @override
  String get detailSourceMissingKey => 'API कुंजी आवश्यक है';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'अपडेट किया गया $date';
  }

  @override
  String get detailStale =>
      'पुराना कैश किया गया डेटा दिखाया जा रहा है — रीफ़्रेश विफल रहा';

  @override
  String get detailSources => 'स्रोत';

  @override
  String get detailNoData => 'अभी कोई जानकारी उपलब्ध नहीं है।';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsLanguageUnits => 'भाषा और इकाइयाँ';

  @override
  String get settingsLanguageUnitsDesc =>
      'ऐप भाषा, सामग्री भाषा, दूरी/तापमान इकाइयाँ';

  @override
  String get settingsApiKeys => 'API कुंजियाँ';

  @override
  String get settingsApiKeysDesc =>
      'मौसम और खोज — जगहों/जियोकोडिंग के लिए कुंजी की आवश्यकता नहीं';

  @override
  String get settingsAiAssistant => 'AI सहायक';

  @override
  String get settingsAiAssistantDesc =>
      'आपकी अपनी LLM API कुंजी, विवरण स्तर, स्रोत';

  @override
  String get settingsDataPrivacy => 'डेटा और गोपनीयता';

  @override
  String get settingsDataPrivacyDesc =>
      'कैश, इतिहास, स्थान अनुमति, गति, फ़ॉन्ट आकार';

  @override
  String get languageSettingsTitle => 'भाषा और इकाइयाँ';

  @override
  String get uiLanguage => 'ऐप भाषा';

  @override
  String get contentLanguage => 'सामग्री भाषा';

  @override
  String get contentLanguageDesc =>
      'AI द्वारा सारांशित सामग्री के लिए उपयोग की जाने वाली भाषा — ऐप भाषा से भिन्न हो सकती है';

  @override
  String get distanceUnit => 'दूरी इकाई';

  @override
  String get temperatureUnit => 'तापमान इकाई';

  @override
  String get currencyFormat => 'मुद्रा प्रारूप';

  @override
  String get km => 'किलोमीटर';

  @override
  String get miles => 'मील';

  @override
  String get celsius => 'सेल्सियस (°C)';

  @override
  String get fahrenheit => 'फ़ारेनहाइट (°F)';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get apiKeysTitle => 'API कुंजियाँ';

  @override
  String get placesNoKeyNote =>
      'खोज, आस-पास की जगहें और निकटतम हवाई अड्डा OpenStreetMap (Nominatim + Overpass) पर चलते हैं — मुफ़्त, किसी API कुंजी की आवश्यकता नहीं।';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API कुंजी';

  @override
  String get weatherApiKeyDesc => 'वर्तमान मौसम के लिए आवश्यक।';

  @override
  String get searchApiKeyLabel => 'Tavily खोज API कुंजी (वैकल्पिक)';

  @override
  String get searchApiKeyDesc =>
      'AI द्वारा सारांशित उत्तरों को वास्तविक खोज परिणामों पर आधारित करता है। इसके बिना, AI केवल सामान्य ज्ञान से उत्तर देता है।';

  @override
  String get llmSettingsTitle => 'AI सहायक';

  @override
  String get llmEnabled => 'AI सारांश सक्षम करें';

  @override
  String get llmEnabledDesc =>
      'बंद होने पर, LLM को कॉल करने के बजाय वे आइटम खाली छोड़ दिए जाते हैं';

  @override
  String get byokProviderLabel => 'प्रदाता';

  @override
  String get byokApiKey => 'API कुंजी';

  @override
  String get byokApiKeyHint => 'केवल इस डिवाइस पर सुरक्षित रूप से संग्रहीत';

  @override
  String get detailLevel => 'विवरण स्तर';

  @override
  String get detailLevelShort => 'संक्षिप्त';

  @override
  String get detailLevelDetailed => 'विस्तृत';

  @override
  String get showSources => 'स्रोत दिखाएँ';

  @override
  String get showSourcesDesc => 'AI सारांश जिन लिंक पर आधारित थे उन्हें दिखाएँ';

  @override
  String get llmDisclaimer =>
      '\"AI द्वारा सारांशित\" के रूप में चिह्नित सामग्री गलत हो सकती है। हमेशा वीज़ा, स्वास्थ्य और सुरक्षा जानकारी की पुष्टि आधिकारिक स्रोतों से करें।';

  @override
  String get privacySettingsTitle => 'डेटा और गोपनीयता';

  @override
  String get cacheSize => 'कैश आकार';

  @override
  String get clearCache => 'कैश साफ़ करें';

  @override
  String get clearCacheConfirm =>
      'इससे सभी कैश किए गए स्थान डेटा हट जाएँगे। जारी रखें?';

  @override
  String get locationHistory => 'स्थान इतिहास';

  @override
  String get clearHistory => 'इतिहास साफ़ करें';

  @override
  String get clearHistoryConfirm => 'इससे आपका खोज इतिहास हट जाएगा। जारी रखें?';

  @override
  String get gpsPermission => 'मेरा स्थान उपयोग करें';

  @override
  String get gpsPermissionDesc =>
      'आपके 15 किमी के दायरे में जगहें खोजने के लिए उपयोग किया जाता है। आप हमेशा इसके बजाय मैन्युअल रूप से खोज सकते हैं।';

  @override
  String get reducedMotion => 'गति कम करें';

  @override
  String get reducedMotionDesc => 'नोड-ग्राफ़ में परिवेशी एनिमेशन बंद करें';

  @override
  String get fontSize => 'फ़ॉन्ट आकार';

  @override
  String get historyTitle => 'इतिहास';

  @override
  String get historyEmpty => 'अभी तक कोई जगह नहीं खोजी गई।';

  @override
  String get save => 'सहेजें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get close => 'बंद करें';

  @override
  String get groupExplore => 'अन्वेषण करें';

  @override
  String get groupPractical => 'व्यावहारिक';

  @override
  String get groupSafety => 'सुरक्षा और स्वास्थ्य';

  @override
  String get groupCulture => 'संस्कृति';

  @override
  String get groupEntryStay => 'प्रवेश और ठहराव';
}
