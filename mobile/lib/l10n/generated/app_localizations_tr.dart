// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Bir yer, şehir veya adres ara';

  @override
  String get searchButton => 'Ara';

  @override
  String get searchRecent => 'Son aramalar';

  @override
  String get searchTryDemo => 'Bir demo dene (Da Lat)';

  @override
  String get searchNoResults => 'Eşleşme bulunamadı. Farklı bir arama deneyin.';

  @override
  String get searchError =>
      'Bir şeyler ters gitti. Bağlantınızı kontrol edin veya demoyu deneyin.';

  @override
  String get searchChooseMatch => 'Bir yer seçin';

  @override
  String get graphBack => 'Geri';

  @override
  String get graphSettings => 'Ayarlar';

  @override
  String get graphHistory => 'Geçmiş';

  @override
  String get graphRefresh => 'Yenile';

  @override
  String get graphRefreshAll => 'Tümünü yenile';

  @override
  String get graphLoading => 'Bilgiler toplanıyor…';

  @override
  String get graphError => 'Bu konum yüklenemedi.';

  @override
  String get graphRetry => 'Tekrar dene';

  @override
  String get detailSourceLlm => 'Yapay zeka özeti';

  @override
  String get detailSourceApi => 'Canlı veri';

  @override
  String get detailSourceStatic => 'Referans veri';

  @override
  String get detailSourceSearch => 'Ham arama sonuçları';

  @override
  String get detailSourceMissingKey => 'API anahtarı gerekli';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Güncellendi: $date';
  }

  @override
  String get detailStale =>
      'Daha eski önbelleğe alınmış veriler gösteriliyor — yenileme başarısız oldu';

  @override
  String get detailSources => 'Kaynaklar';

  @override
  String get detailNoData => 'Henüz bilgi yok.';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsLanguageUnits => 'Dil ve birimler';

  @override
  String get settingsLanguageUnitsDesc =>
      'Arayüz dili, içerik dili, mesafe/sıcaklık birimleri';

  @override
  String get settingsApiKeys => 'API anahtarları';

  @override
  String get settingsApiKeysDesc =>
      'Hava durumu ve arama — yerler/coğrafi kodlama anahtar gerektirmez';

  @override
  String get settingsAiAssistant => 'Yapay Zeka Asistanı';

  @override
  String get settingsAiAssistantDesc =>
      'Kendi LLM API anahtarınız, ayrıntı düzeyi, kaynaklar';

  @override
  String get settingsDataPrivacy => 'Veri ve gizlilik';

  @override
  String get settingsDataPrivacyDesc =>
      'Önbellek, geçmiş, konum izni, hareket, yazı tipi boyutu';

  @override
  String get languageSettingsTitle => 'Dil ve birimler';

  @override
  String get uiLanguage => 'Uygulama dili';

  @override
  String get contentLanguage => 'İçerik dili';

  @override
  String get contentLanguageDesc =>
      'Yapay zeka tarafından özetlenen içerik için kullanılan dil — uygulama dilinden farklı olabilir';

  @override
  String get distanceUnit => 'Mesafe birimi';

  @override
  String get temperatureUnit => 'Sıcaklık birimi';

  @override
  String get currencyFormat => 'Para birimi biçimi';

  @override
  String get km => 'Kilometre';

  @override
  String get miles => 'Mil';

  @override
  String get celsius => 'Santigrat (°C)';

  @override
  String get fahrenheit => 'Fahrenhayt (°F)';

  @override
  String get systemDefault => 'Sistem varsayılanı';

  @override
  String get apiKeysTitle => 'API anahtarları';

  @override
  String get placesNoKeyNote =>
      'Arama, yakındaki yerler ve en yakın havalimanı OpenStreetMap (Nominatim + Overpass) üzerinde çalışır — ücretsiz, API anahtarı gerekmez.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API anahtarı';

  @override
  String get weatherApiKeyDesc => 'Güncel hava durumu için gereklidir.';

  @override
  String get searchApiKeyLabel => 'Tavily arama API anahtarı (isteğe bağlı)';

  @override
  String get searchApiKeyDesc =>
      'Yapay zeka özetli yanıtları gerçek arama sonuçlarına dayandırır. Olmadan, yapay zeka yalnızca genel bilgiyle yanıt verir.';

  @override
  String get llmSettingsTitle => 'Yapay Zeka Asistanı';

  @override
  String get llmEnabled => 'Yapay zeka özetlerini etkinleştir';

  @override
  String get llmEnabledDesc =>
      'Kapalıyken, bu öğeler bir LLM çağırmak yerine sadece boş bırakılır';

  @override
  String get byokProviderLabel => 'Sağlayıcı';

  @override
  String get byokApiKey => 'API anahtarı';

  @override
  String get byokApiKeyHint => 'Yalnızca bu cihazda güvenli şekilde saklanır';

  @override
  String get llmKeyBuiltIn =>
      'This provider uses a shared key built into the app — no key needed.';

  @override
  String get detailLevel => 'Ayrıntı düzeyi';

  @override
  String get detailLevelShort => 'Kısa';

  @override
  String get detailLevelDetailed => 'Ayrıntılı';

  @override
  String get showSources => 'Kaynakları göster';

  @override
  String get showSourcesDesc =>
      'Yapay zeka özetlerinin dayandığı bağlantıları göster';

  @override
  String get llmDisclaimer =>
      '\"Yapay zeka özeti\" olarak işaretlenen içerik hatalı olabilir. Vize, sağlık ve güvenlik bilgilerini her zaman resmi kaynaklardan doğrulayın.';

  @override
  String get privacySettingsTitle => 'Veri ve gizlilik';

  @override
  String get cacheSize => 'Önbellek boyutu';

  @override
  String get clearCache => 'Önbelleği temizle';

  @override
  String get clearCacheConfirm =>
      'Bu, önbelleğe alınmış tüm konum verilerini kaldıracak. Devam edilsin mi?';

  @override
  String get locationHistory => 'Konum geçmişi';

  @override
  String get clearHistory => 'Geçmişi temizle';

  @override
  String get clearHistoryConfirm =>
      'Bu, arama geçmişinizi kaldıracak. Devam edilsin mi?';

  @override
  String get gpsPermission => 'Konumumu kullan';

  @override
  String get gpsPermissionDesc =>
      'Sizden 15 km yarıçapındaki yerleri bulmak için kullanılır. Bunun yerine her zaman manuel arama yapabilirsiniz.';

  @override
  String get reducedMotion => 'Hareketi azalt';

  @override
  String get reducedMotionDesc => 'Düğüm grafiğindeki ortam animasyonunu kapat';

  @override
  String get fontSize => 'Yazı tipi boyutu';

  @override
  String get historyTitle => 'Geçmiş';

  @override
  String get historyEmpty => 'Henüz aranan bir konum yok.';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get close => 'Kapat';

  @override
  String get groupExplore => 'Keşfet';

  @override
  String get groupPractical => 'Pratik';

  @override
  String get groupSafety => 'Güvenlik ve sağlık';

  @override
  String get groupCulture => 'Kültür';

  @override
  String get groupEntryStay => 'Giriş ve konaklama';
}
