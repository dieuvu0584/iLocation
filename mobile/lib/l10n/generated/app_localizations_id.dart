// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Cari tempat, kota, atau alamat';

  @override
  String get searchButton => 'Cari';

  @override
  String get searchRecent => 'Terbaru';

  @override
  String get searchTryDemo => 'Coba demo (Da Lat)';

  @override
  String get searchNoResults =>
      'Tidak ada hasil yang cocok. Coba pencarian lain.';

  @override
  String get searchError =>
      'Terjadi kesalahan. Periksa koneksi Anda atau coba demo.';

  @override
  String get searchChooseMatch => 'Pilih tempat';

  @override
  String get graphBack => 'Kembali';

  @override
  String get graphSettings => 'Pengaturan';

  @override
  String get graphHistory => 'Riwayat';

  @override
  String get graphRefresh => 'Segarkan';

  @override
  String get graphRefreshAll => 'Segarkan semua';

  @override
  String get graphLoading => 'Mengumpulkan informasi…';

  @override
  String get graphError => 'Tidak dapat memuat lokasi ini.';

  @override
  String get graphRetry => 'Coba lagi';

  @override
  String get detailSourceLlm => 'Diringkas oleh AI';

  @override
  String get detailSourceApi => 'Data langsung';

  @override
  String get detailSourceStatic => 'Data referensi';

  @override
  String get detailSourceSearch => 'Hasil pencarian mentah';

  @override
  String get detailSourceMissingKey => 'Perlu kunci API';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Diperbarui $date';
  }

  @override
  String get detailStale =>
      'Menampilkan data cache yang lebih lama — gagal menyegarkan';

  @override
  String get detailSources => 'Sumber';

  @override
  String get detailNoData => 'Belum ada informasi yang tersedia.';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get settingsLanguageUnits => 'Bahasa & Satuan';

  @override
  String get settingsLanguageUnitsDesc =>
      'Bahasa aplikasi, bahasa konten, satuan jarak/suhu';

  @override
  String get settingsApiKeys => 'Kunci API';

  @override
  String get settingsApiKeysDesc =>
      'Cuaca dan pencarian — tempat/geocoding tidak memerlukan kunci';

  @override
  String get settingsAiAssistant => 'Asisten AI';

  @override
  String get settingsAiAssistantDesc =>
      'Kunci API LLM Anda sendiri, tingkat detail, sumber';

  @override
  String get settingsDataPrivacy => 'Data & Privasi';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, riwayat, izin lokasi, gerakan, ukuran huruf';

  @override
  String get languageSettingsTitle => 'Bahasa & Satuan';

  @override
  String get uiLanguage => 'Bahasa aplikasi';

  @override
  String get contentLanguage => 'Bahasa konten';

  @override
  String get contentLanguageDesc =>
      'Bahasa yang digunakan untuk konten yang diringkas AI — dapat berbeda dari bahasa aplikasi';

  @override
  String get distanceUnit => 'Satuan jarak';

  @override
  String get temperatureUnit => 'Satuan suhu';

  @override
  String get currencyFormat => 'Format mata uang';

  @override
  String get km => 'Kilometer';

  @override
  String get miles => 'Mil';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Default sistem';

  @override
  String get apiKeysTitle => 'Kunci API';

  @override
  String get placesNoKeyNote =>
      'Pencarian, tempat terdekat, dan bandara terdekat berjalan di OpenStreetMap (Nominatim + Overpass) — gratis, tidak perlu kunci API.';

  @override
  String get weatherApiKeyLabel => 'Kunci API OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Diperlukan untuk cuaca saat ini.';

  @override
  String get searchApiKeyLabel => 'Kunci API pencarian Tavily (opsional)';

  @override
  String get searchApiKeyDesc =>
      'Mendasarkan jawaban ringkasan AI pada hasil pencarian nyata. Tanpa ini, AI hanya menjawab dari pengetahuan umum.';

  @override
  String get llmSettingsTitle => 'Asisten AI';

  @override
  String get llmEnabled => 'Aktifkan ringkasan AI';

  @override
  String get llmEnabledDesc =>
      'Saat dinonaktifkan, item tersebut dibiarkan kosong alih-alih memanggil LLM';

  @override
  String get byokProviderLabel => 'Penyedia';

  @override
  String get byokApiKey => 'Kunci API';

  @override
  String get byokApiKeyHint => 'Disimpan dengan aman hanya di perangkat ini';

  @override
  String get detailLevel => 'Tingkat detail';

  @override
  String get detailLevelShort => 'Singkat';

  @override
  String get detailLevelDetailed => 'Rinci';

  @override
  String get showSources => 'Tampilkan sumber';

  @override
  String get showSourcesDesc =>
      'Tampilkan tautan yang menjadi dasar ringkasan AI';

  @override
  String get llmDisclaimer =>
      'Konten yang ditandai \"Diringkas oleh AI\" mungkin tidak akurat. Selalu verifikasi informasi visa, kesehatan, dan keselamatan dengan sumber resmi.';

  @override
  String get privacySettingsTitle => 'Data & Privasi';

  @override
  String get cacheSize => 'Ukuran cache';

  @override
  String get clearCache => 'Hapus cache';

  @override
  String get clearCacheConfirm =>
      'Ini akan menghapus semua data lokasi yang di-cache. Lanjutkan?';

  @override
  String get locationHistory => 'Riwayat lokasi';

  @override
  String get clearHistory => 'Hapus riwayat';

  @override
  String get clearHistoryConfirm =>
      'Ini akan menghapus riwayat pencarian Anda. Lanjutkan?';

  @override
  String get gpsPermission => 'Gunakan lokasi saya';

  @override
  String get gpsPermissionDesc =>
      'Digunakan untuk menemukan tempat dalam radius 15 km dari Anda. Anda selalu bisa mencari secara manual sebagai gantinya.';

  @override
  String get reducedMotion => 'Kurangi gerakan';

  @override
  String get reducedMotionDesc => 'Matikan animasi ambient di grafik node';

  @override
  String get fontSize => 'Ukuran huruf';

  @override
  String get historyTitle => 'Riwayat';

  @override
  String get historyEmpty => 'Belum ada lokasi yang dicari.';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get close => 'Tutup';

  @override
  String get groupExplore => 'Jelajahi';

  @override
  String get groupPractical => 'Praktis';

  @override
  String get groupSafety => 'Keselamatan & Kesehatan';

  @override
  String get groupCulture => 'Budaya';

  @override
  String get groupEntryStay => 'Masuk & Tinggal';
}
