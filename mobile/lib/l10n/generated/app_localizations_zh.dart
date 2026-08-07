// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => '搜索地点、城市或地址';

  @override
  String get searchButton => '搜索';

  @override
  String get searchRecent => '最近搜索';

  @override
  String get searchTryDemo => '试用演示（大叻）';

  @override
  String get searchNoResults => '未找到匹配结果，请尝试其他搜索词。';

  @override
  String get searchError => '出现问题。请检查网络连接或试用演示。';

  @override
  String get searchChooseMatch => '选择一个地点';

  @override
  String get graphBack => '返回';

  @override
  String get graphSettings => '设置';

  @override
  String get graphHistory => '历史记录';

  @override
  String get graphRefresh => '刷新';

  @override
  String get graphRefreshAll => '全部刷新';

  @override
  String get graphLoading => '正在收集信息…';

  @override
  String get graphError => '无法加载此地点。';

  @override
  String get graphRetry => '重试';

  @override
  String get detailSourceLlm => 'AI 摘要';

  @override
  String get detailSourceApi => '实时数据';

  @override
  String get detailSourceStatic => '参考数据';

  @override
  String get detailSourceSearch => '原始搜索结果';

  @override
  String get detailSourceMissingKey => '需要 API 密钥';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return '更新于 $date';
  }

  @override
  String get detailStale => '正在显示较旧的缓存数据 — 刷新失败';

  @override
  String get detailSources => '来源';

  @override
  String get detailNoData => '暂无可用信息。';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguageUnits => '语言与单位';

  @override
  String get settingsLanguageUnitsDesc => '应用语言、内容语言、距离/温度单位';

  @override
  String get settingsApiKeys => 'API 密钥';

  @override
  String get settingsApiKeysDesc => '天气与搜索 — 地点/地理编码无需密钥';

  @override
  String get settingsAiAssistant => 'AI 助手';

  @override
  String get settingsAiAssistantDesc => '您自己的 LLM API 密钥、详细程度、来源';

  @override
  String get settingsDataPrivacy => '数据与隐私';

  @override
  String get settingsDataPrivacyDesc => '缓存、历史记录、位置权限、动效、字体大小';

  @override
  String get languageSettingsTitle => '语言与单位';

  @override
  String get uiLanguage => '应用语言';

  @override
  String get contentLanguage => '内容语言';

  @override
  String get contentLanguageDesc => '用于 AI 摘要内容的语言 — 可与应用语言不同';

  @override
  String get distanceUnit => '距离单位';

  @override
  String get temperatureUnit => '温度单位';

  @override
  String get currencyFormat => '货币格式';

  @override
  String get km => '千米';

  @override
  String get miles => '英里';

  @override
  String get celsius => '摄氏度 (°C)';

  @override
  String get fahrenheit => '华氏度 (°F)';

  @override
  String get systemDefault => '系统默认';

  @override
  String get apiKeysTitle => 'API 密钥';

  @override
  String get placesNoKeyNote =>
      '搜索、附近地点和最近机场均基于 OpenStreetMap（Nominatim + Overpass）— 免费，无需 API 密钥。';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API 密钥';

  @override
  String get weatherApiKeyDesc => '查看当前天气所必需。';

  @override
  String get searchApiKeyLabel => 'Tavily 搜索 API 密钥（可选）';

  @override
  String get searchApiKeyDesc => '让 AI 摘要的回答基于真实搜索结果。若未设置，AI 将仅根据通用知识回答。';

  @override
  String get llmSettingsTitle => 'AI 助手';

  @override
  String get llmEnabled => '启用 AI 摘要';

  @override
  String get llmEnabledDesc => '关闭后，这些项目将留空，而不会调用 LLM';

  @override
  String get byokProviderLabel => '提供商';

  @override
  String get byokApiKey => 'API 密钥';

  @override
  String get byokApiKeyHint => '仅安全存储在此设备上';

  @override
  String get llmKeyBuiltIn =>
      'This provider uses a shared key built into the app — no key needed.';

  @override
  String get detailLevel => '详细程度';

  @override
  String get detailLevelShort => '简短';

  @override
  String get detailLevelDetailed => '详细';

  @override
  String get showSources => '显示来源';

  @override
  String get showSourcesDesc => '显示 AI 摘要所依据的链接';

  @override
  String get llmDisclaimer => '标记为“AI 摘要”的内容可能不准确。请务必通过官方渠道核实签证、健康和安全信息。';

  @override
  String get privacySettingsTitle => '数据与隐私';

  @override
  String get cacheSize => '缓存大小';

  @override
  String get clearCache => '清除缓存';

  @override
  String get clearCacheConfirm => '这将删除所有已缓存的地点数据。是否继续？';

  @override
  String get locationHistory => '地点历史';

  @override
  String get clearHistory => '清除历史记录';

  @override
  String get clearHistoryConfirm => '这将删除您的搜索历史。是否继续？';

  @override
  String get gpsPermission => '使用我的位置';

  @override
  String get gpsPermissionDesc => '用于查找您 15 公里范围内的地点。您也可以随时改为手动搜索。';

  @override
  String get reducedMotion => '减少动效';

  @override
  String get reducedMotionDesc => '关闭节点图中的环境动画';

  @override
  String get fontSize => '字体大小';

  @override
  String get historyTitle => '历史记录';

  @override
  String get historyEmpty => '尚未查看过任何地点。';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get close => '关闭';

  @override
  String get groupExplore => '探索';

  @override
  String get groupPractical => '实用信息';

  @override
  String get groupSafety => '安全与健康';

  @override
  String get groupCulture => '文化';

  @override
  String get groupEntryStay => '入境与住宿';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => '搜尋地點、城市或地址';

  @override
  String get searchButton => '搜尋';

  @override
  String get searchRecent => '最近搜尋';

  @override
  String get searchTryDemo => '試用範例（大叻）';

  @override
  String get searchNoResults => '找不到符合的結果，請嘗試其他搜尋字詞。';

  @override
  String get searchError => '發生錯誤，請檢查網路連線或試用範例。';

  @override
  String get searchChooseMatch => '選擇一個地點';

  @override
  String get graphBack => '返回';

  @override
  String get graphSettings => '設定';

  @override
  String get graphHistory => '歷史紀錄';

  @override
  String get graphRefresh => '重新整理';

  @override
  String get graphRefreshAll => '全部重新整理';

  @override
  String get graphLoading => '正在收集資訊…';

  @override
  String get graphError => '無法載入此地點。';

  @override
  String get graphRetry => '重試';

  @override
  String get detailSourceLlm => 'AI 摘要';

  @override
  String get detailSourceApi => '即時資料';

  @override
  String get detailSourceStatic => '參考資料';

  @override
  String get detailSourceSearch => '原始搜尋結果';

  @override
  String get detailSourceMissingKey => '需要 API 金鑰';

  @override
  String detailUpdatedAt(String date) {
    return '更新於 $date';
  }

  @override
  String get detailStale => '正在顯示較舊的快取資料 — 重新整理失敗';

  @override
  String get detailSources => '資料來源';

  @override
  String get detailNoData => '目前尚無可用資訊。';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguageUnits => '語言與單位';

  @override
  String get settingsLanguageUnitsDesc => '應用程式語言、內容語言、距離/溫度單位';

  @override
  String get settingsApiKeys => 'API 金鑰';

  @override
  String get settingsApiKeysDesc => '天氣與搜尋 — 地點/地理編碼不需要金鑰';

  @override
  String get settingsAiAssistant => 'AI 助理';

  @override
  String get settingsAiAssistantDesc => '您自己的 LLM API 金鑰、詳細程度、資料來源';

  @override
  String get settingsDataPrivacy => '資料與隱私';

  @override
  String get settingsDataPrivacyDesc => '快取、歷史紀錄、位置權限、動態效果、字型大小';

  @override
  String get languageSettingsTitle => '語言與單位';

  @override
  String get uiLanguage => '應用程式語言';

  @override
  String get contentLanguage => '內容語言';

  @override
  String get contentLanguageDesc => '用於 AI 摘要內容的語言 — 可與應用程式語言不同';

  @override
  String get distanceUnit => '距離單位';

  @override
  String get temperatureUnit => '溫度單位';

  @override
  String get currencyFormat => '貨幣格式';

  @override
  String get km => '公里';

  @override
  String get miles => '英里';

  @override
  String get celsius => '攝氏 (°C)';

  @override
  String get fahrenheit => '華氏 (°F)';

  @override
  String get systemDefault => '系統預設';

  @override
  String get apiKeysTitle => 'API 金鑰';

  @override
  String get placesNoKeyNote =>
      '搜尋、附近地點和最近機場皆使用 OpenStreetMap（Nominatim + Overpass）— 免費，不需要 API 金鑰。';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API 金鑰';

  @override
  String get weatherApiKeyDesc => '顯示目前天氣所需。';

  @override
  String get searchApiKeyLabel => 'Tavily 搜尋 API 金鑰（選填）';

  @override
  String get searchApiKeyDesc => '讓 AI 摘要的回答基於真實搜尋結果。若未設定，AI 僅會依據一般知識回答。';

  @override
  String get llmSettingsTitle => 'AI 助理';

  @override
  String get llmEnabled => '啟用 AI 摘要';

  @override
  String get llmEnabledDesc => '關閉後，這些項目將留空，而不會呼叫 LLM';

  @override
  String get byokProviderLabel => '供應商';

  @override
  String get byokApiKey => 'API 金鑰';

  @override
  String get byokApiKeyHint => '僅安全儲存於此裝置';

  @override
  String get detailLevel => '詳細程度';

  @override
  String get detailLevelShort => '簡短';

  @override
  String get detailLevelDetailed => '詳細';

  @override
  String get showSources => '顯示資料來源';

  @override
  String get showSourcesDesc => '顯示 AI 摘要所依據的連結';

  @override
  String get llmDisclaimer => '標示為「AI 摘要」的內容可能不準確。請務必透過官方管道核實簽證、健康與安全資訊。';

  @override
  String get privacySettingsTitle => '資料與隱私';

  @override
  String get cacheSize => '快取大小';

  @override
  String get clearCache => '清除快取';

  @override
  String get clearCacheConfirm => '這將刪除所有已快取的地點資料，是否繼續？';

  @override
  String get locationHistory => '地點歷史';

  @override
  String get clearHistory => '清除歷史紀錄';

  @override
  String get clearHistoryConfirm => '這將刪除您的搜尋歷史，是否繼續？';

  @override
  String get gpsPermission => '使用我的位置';

  @override
  String get gpsPermissionDesc => '用於尋找您 15 公里範圍內的地點。您也可以隨時改為手動搜尋。';

  @override
  String get reducedMotion => '減少動態效果';

  @override
  String get reducedMotionDesc => '關閉節點圖中的環境動畫';

  @override
  String get fontSize => '字型大小';

  @override
  String get historyTitle => '歷史紀錄';

  @override
  String get historyEmpty => '尚未查看過任何地點。';

  @override
  String get save => '儲存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '刪除';

  @override
  String get close => '關閉';

  @override
  String get groupExplore => '探索';

  @override
  String get groupPractical => '實用資訊';

  @override
  String get groupSafety => '安全與健康';

  @override
  String get groupCulture => '文化';

  @override
  String get groupEntryStay => '入境與住宿';
}
