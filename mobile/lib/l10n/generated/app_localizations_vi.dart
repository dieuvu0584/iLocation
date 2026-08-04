// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Tìm địa điểm, thành phố hoặc địa chỉ';

  @override
  String get searchButton => 'Tìm kiếm';

  @override
  String get searchRecent => 'Gần đây';

  @override
  String get searchTryDemo => 'Dùng thử (Đà Lạt)';

  @override
  String get searchNoResults =>
      'Không tìm thấy kết quả phù hợp. Hãy thử từ khóa khác.';

  @override
  String get searchError =>
      'Không kết nối được máy chủ. Kiểm tra mạng hoặc dùng thử demo.';

  @override
  String get searchChooseMatch => 'Chọn địa điểm';

  @override
  String get graphBack => 'Quay lại';

  @override
  String get graphSettings => 'Cài đặt';

  @override
  String get graphHistory => 'Lịch sử';

  @override
  String get graphRefresh => 'Làm mới';

  @override
  String get graphRefreshAll => 'Làm mới tất cả';

  @override
  String get graphLoading => 'Đang tổng hợp thông tin…';

  @override
  String get graphError => 'Không tải được thông tin địa điểm này.';

  @override
  String get graphRetry => 'Thử lại';

  @override
  String get detailSourceLlm => 'AI tổng hợp';

  @override
  String get detailSourceApi => 'Dữ liệu trực tiếp';

  @override
  String get detailSourceStatic => 'Dữ liệu tham chiếu';

  @override
  String get detailSourceSearch => 'Kết quả tìm kiếm thô';

  @override
  String detailUpdatedAt(String date) {
    return 'Cập nhật $date';
  }

  @override
  String get detailStale => 'Đang hiển thị dữ liệu cũ — làm mới thất bại';

  @override
  String get detailSources => 'Nguồn';

  @override
  String get detailNoData => 'Chưa có thông tin.';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get settingsLanguageUnits => 'Ngôn ngữ & Đơn vị';

  @override
  String get settingsLanguageUnitsDesc =>
      'Ngôn ngữ giao diện, ngôn ngữ nội dung, đơn vị khoảng cách/nhiệt độ';

  @override
  String get settingsAiAssistant => 'Trợ lý AI';

  @override
  String get settingsAiAssistantDesc =>
      'Gói miễn phí hoặc API key riêng, độ chi tiết, nguồn';

  @override
  String get settingsDataPrivacy => 'Dữ liệu & Quyền riêng tư';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, lịch sử, quyền vị trí, chuyển động, cỡ chữ';

  @override
  String get languageSettingsTitle => 'Ngôn ngữ & Đơn vị';

  @override
  String get uiLanguage => 'Ngôn ngữ ứng dụng';

  @override
  String get contentLanguage => 'Ngôn ngữ nội dung';

  @override
  String get contentLanguageDesc =>
      'Ngôn ngữ dùng cho nội dung AI tổng hợp — có thể khác ngôn ngữ giao diện';

  @override
  String get distanceUnit => 'Đơn vị khoảng cách';

  @override
  String get temperatureUnit => 'Đơn vị nhiệt độ';

  @override
  String get currencyFormat => 'Định dạng tiền tệ';

  @override
  String get km => 'Kilômét';

  @override
  String get miles => 'Dặm';

  @override
  String get celsius => 'Độ C (°C)';

  @override
  String get fahrenheit => 'Độ F (°F)';

  @override
  String get systemDefault => 'Theo hệ thống';

  @override
  String get llmSettingsTitle => 'Trợ lý AI';

  @override
  String get llmEnabled => 'Bật tóm tắt AI';

  @override
  String get llmEnabledDesc =>
      'Khi tắt, bạn sẽ thấy kết quả tìm kiếm thô thay vì tóm tắt AI';

  @override
  String get providerMode => 'Nhà cung cấp';

  @override
  String get providerFree => 'Miễn phí (của ứng dụng)';

  @override
  String get providerByok => 'Dùng API key của tôi';

  @override
  String freeTierUsage(int used, int limit) {
    return 'Đã dùng $used/$limit lượt hôm nay';
  }

  @override
  String get freeTierWarning => 'Bạn sắp đạt giới hạn miễn phí hôm nay.';

  @override
  String get byokProviderLabel => 'Nhà cung cấp';

  @override
  String get byokApiKey => 'API key';

  @override
  String get byokApiKeyHint => 'Chỉ lưu an toàn trên thiết bị này';

  @override
  String get fallbackEnabled => 'Chuyển sang gói miễn phí khi bị giới hạn';

  @override
  String get fallbackEnabledDesc =>
      'Nếu nhà cung cấp của bạn bị rate-limit, tự động thử lại bằng gói miễn phí';

  @override
  String get detailLevel => 'Độ chi tiết';

  @override
  String get detailLevelShort => 'Ngắn gọn';

  @override
  String get detailLevelDetailed => 'Chi tiết';

  @override
  String get showSources => 'Hiện nguồn';

  @override
  String get showSourcesDesc => 'Hiển thị link nguồn mà AI dựa vào để tóm tắt';

  @override
  String get llmDisclaimer =>
      'Nội dung \"AI tổng hợp\" có thể không chính xác. Luôn kiểm tra visa, y tế và an toàn với nguồn chính thức.';

  @override
  String get privacySettingsTitle => 'Dữ liệu & Quyền riêng tư';

  @override
  String get cacheSize => 'Dung lượng cache';

  @override
  String get clearCache => 'Xóa cache';

  @override
  String get clearCacheConfirm =>
      'Thao tác này sẽ xóa toàn bộ dữ liệu địa điểm đã lưu. Tiếp tục?';

  @override
  String get locationHistory => 'Lịch sử địa điểm';

  @override
  String get clearHistory => 'Xóa lịch sử';

  @override
  String get clearHistoryConfirm =>
      'Thao tác này sẽ xóa lịch sử tìm kiếm của bạn. Tiếp tục?';

  @override
  String get gpsPermission => 'Dùng vị trí của tôi';

  @override
  String get gpsPermissionDesc =>
      'Dùng để tìm địa điểm trong bán kính 15km quanh bạn. Bạn luôn có thể tìm kiếm thủ công thay thế.';

  @override
  String get reducedMotion => 'Giảm chuyển động';

  @override
  String get reducedMotionDesc =>
      'Tắt hiệu ứng chuyển động nền trong node-graph';

  @override
  String get fontSize => 'Cỡ chữ';

  @override
  String get historyTitle => 'Lịch sử';

  @override
  String get historyEmpty => 'Chưa có địa điểm nào được tra cứu.';

  @override
  String get save => 'Lưu';

  @override
  String get cancel => 'Hủy';

  @override
  String get delete => 'Xóa';

  @override
  String get close => 'Đóng';

  @override
  String get groupExplore => 'Khám phá';

  @override
  String get groupPractical => 'Thực dụng';

  @override
  String get groupSafety => 'An toàn & Sức khỏe';

  @override
  String get groupCulture => 'Văn hóa';

  @override
  String get groupEntryStay => 'Nhập cảnh & Lưu trú';
}
