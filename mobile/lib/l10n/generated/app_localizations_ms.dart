// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Cari tempat, bandar, atau alamat';

  @override
  String get searchButton => 'Cari';

  @override
  String get searchRecent => 'Terkini';

  @override
  String get searchTryDemo => 'Cuba demo (Da Lat)';

  @override
  String get searchNoResults => 'Tiada padanan dijumpai. Cuba carian lain.';

  @override
  String get searchError =>
      'Sesuatu tidak kena. Semak sambungan anda atau cuba demo.';

  @override
  String get searchChooseMatch => 'Pilih tempat';

  @override
  String get graphBack => 'Kembali';

  @override
  String get graphSettings => 'Tetapan';

  @override
  String get graphHistory => 'Sejarah';

  @override
  String get graphRefresh => 'Segar semula';

  @override
  String get graphRefreshAll => 'Segar semula semua';

  @override
  String get graphLoading => 'Mengumpul maklumat…';

  @override
  String get graphError => 'Tidak dapat memuatkan lokasi ini.';

  @override
  String get graphRetry => 'Cuba lagi';

  @override
  String get detailSourceLlm => 'Diringkaskan oleh AI';

  @override
  String get detailSourceApi => 'Data langsung';

  @override
  String get detailSourceStatic => 'Data rujukan';

  @override
  String get detailSourceSearch => 'Keputusan carian mentah';

  @override
  String get detailSourceMissingKey => 'Memerlukan kunci API';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Dikemas kini $date';
  }

  @override
  String get detailStale =>
      'Memaparkan data cache yang lebih lama — penyegaran gagal';

  @override
  String get detailSources => 'Sumber';

  @override
  String get detailNoData => 'Belum ada maklumat tersedia.';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get settingsLanguageUnits => 'Bahasa & Unit';

  @override
  String get settingsLanguageUnitsDesc =>
      'Bahasa aplikasi, bahasa kandungan, unit jarak/suhu';

  @override
  String get settingsApiKeys => 'Kunci API';

  @override
  String get settingsApiKeysDesc =>
      'Cuaca dan carian — tempat/geokod tidak memerlukan kunci';

  @override
  String get settingsAiAssistant => 'Pembantu AI';

  @override
  String get settingsAiAssistantDesc =>
      'Kunci API LLM anda sendiri, tahap perincian, sumber';

  @override
  String get settingsDataPrivacy => 'Data & Privasi';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, sejarah, kebenaran lokasi, pergerakan, saiz fon';

  @override
  String get languageSettingsTitle => 'Bahasa & Unit';

  @override
  String get uiLanguage => 'Bahasa aplikasi';

  @override
  String get contentLanguage => 'Bahasa kandungan';

  @override
  String get contentLanguageDesc =>
      'Bahasa yang digunakan untuk kandungan yang diringkaskan AI — boleh berbeza daripada bahasa aplikasi';

  @override
  String get distanceUnit => 'Unit jarak';

  @override
  String get temperatureUnit => 'Unit suhu';

  @override
  String get currencyFormat => 'Format mata wang';

  @override
  String get km => 'Kilometer';

  @override
  String get miles => 'Batu';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Lalai sistem';

  @override
  String get apiKeysTitle => 'Kunci API';

  @override
  String get placesNoKeyNote =>
      'Carian, tempat berdekatan, dan lapangan terbang terdekat berjalan pada OpenStreetMap (Nominatim + Overpass) — percuma, tiada kunci API diperlukan.';

  @override
  String get weatherApiKeyLabel => 'Kunci API OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Diperlukan untuk cuaca semasa.';

  @override
  String get searchApiKeyLabel => 'Kunci API carian Tavily (pilihan)';

  @override
  String get searchApiKeyDesc =>
      'Mengasaskan jawapan ringkasan AI pada keputusan carian sebenar. Tanpanya, AI hanya menjawab daripada pengetahuan umum.';

  @override
  String get llmSettingsTitle => 'Pembantu AI';

  @override
  String get llmEnabled => 'Aktifkan ringkasan AI';

  @override
  String get llmEnabledDesc =>
      'Apabila dimatikan, item tersebut dibiarkan kosong dan bukannya memanggil LLM';

  @override
  String get byokProviderLabel => 'Pembekal';

  @override
  String get byokApiKey => 'Kunci API';

  @override
  String get byokApiKeyHint => 'Disimpan dengan selamat hanya pada peranti ini';

  @override
  String get detailLevel => 'Tahap perincian';

  @override
  String get detailLevelShort => 'Ringkas';

  @override
  String get detailLevelDetailed => 'Terperinci';

  @override
  String get showSources => 'Tunjukkan sumber';

  @override
  String get showSourcesDesc =>
      'Paparkan pautan yang menjadi asas ringkasan AI';

  @override
  String get llmDisclaimer =>
      'Kandungan yang ditanda \"Diringkaskan oleh AI\" mungkin tidak tepat. Sentiasa sahkan maklumat visa, kesihatan, dan keselamatan dengan sumber rasmi.';

  @override
  String get privacySettingsTitle => 'Data & Privasi';

  @override
  String get cacheSize => 'Saiz cache';

  @override
  String get clearCache => 'Kosongkan cache';

  @override
  String get clearCacheConfirm =>
      'Ini akan mengalih keluar semua data lokasi yang dicache. Teruskan?';

  @override
  String get locationHistory => 'Sejarah lokasi';

  @override
  String get clearHistory => 'Kosongkan sejarah';

  @override
  String get clearHistoryConfirm =>
      'Ini akan mengalih keluar sejarah carian anda. Teruskan?';

  @override
  String get gpsPermission => 'Gunakan lokasi saya';

  @override
  String get gpsPermissionDesc =>
      'Digunakan untuk mencari tempat dalam lingkungan 15 km dari anda. Anda sentiasa boleh mencari secara manual sebagai gantinya.';

  @override
  String get reducedMotion => 'Kurangkan pergerakan';

  @override
  String get reducedMotionDesc => 'Matikan animasi ambien dalam graf nod';

  @override
  String get fontSize => 'Saiz fon';

  @override
  String get historyTitle => 'Sejarah';

  @override
  String get historyEmpty => 'Belum ada lokasi dicari.';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Padam';

  @override
  String get close => 'Tutup';

  @override
  String get groupExplore => 'Terokai';

  @override
  String get groupPractical => 'Praktikal';

  @override
  String get groupSafety => 'Keselamatan & Kesihatan';

  @override
  String get groupCulture => 'Budaya';

  @override
  String get groupEntryStay => 'Kemasukan & Penginapan';
}
