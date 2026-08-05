// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => '場所、都市、住所を検索';

  @override
  String get searchButton => '検索';

  @override
  String get searchRecent => '最近の検索';

  @override
  String get searchTryDemo => 'デモを試す（ダラット）';

  @override
  String get searchNoResults => '一致する結果が見つかりません。別のキーワードで検索してください。';

  @override
  String get searchError => '問題が発生しました。接続を確認するか、デモをお試しください。';

  @override
  String get searchChooseMatch => '場所を選択';

  @override
  String get graphBack => '戻る';

  @override
  String get graphSettings => '設定';

  @override
  String get graphHistory => '履歴';

  @override
  String get graphRefresh => '更新';

  @override
  String get graphRefreshAll => 'すべて更新';

  @override
  String get graphLoading => '情報を収集しています…';

  @override
  String get graphError => 'この場所を読み込めませんでした。';

  @override
  String get graphRetry => '再試行';

  @override
  String get detailSourceLlm => 'AIによる要約';

  @override
  String get detailSourceApi => 'ライブデータ';

  @override
  String get detailSourceStatic => '参考データ';

  @override
  String get detailSourceSearch => '検索結果（未加工）';

  @override
  String get detailSourceMissingKey => 'APIキーが必要です';

  @override
  String detailUpdatedAt(String date) {
    return '$date に更新';
  }

  @override
  String get detailStale => '古いキャッシュデータを表示中 — 更新に失敗しました';

  @override
  String get detailSources => '情報源';

  @override
  String get detailNoData => 'まだ情報がありません。';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguageUnits => '言語と単位';

  @override
  String get settingsLanguageUnitsDesc => 'アプリの言語、コンテンツの言語、距離/気温の単位';

  @override
  String get settingsApiKeys => 'APIキー';

  @override
  String get settingsApiKeysDesc => '天気と検索 — 場所/ジオコーディングにキーは不要';

  @override
  String get settingsAiAssistant => 'AIアシスタント';

  @override
  String get settingsAiAssistantDesc => '独自のLLM APIキー、詳細レベル、情報源';

  @override
  String get settingsDataPrivacy => 'データとプライバシー';

  @override
  String get settingsDataPrivacyDesc => 'キャッシュ、履歴、位置情報の許可、モーション、フォントサイズ';

  @override
  String get languageSettingsTitle => '言語と単位';

  @override
  String get uiLanguage => 'アプリの言語';

  @override
  String get contentLanguage => 'コンテンツの言語';

  @override
  String get contentLanguageDesc => 'AIが要約するコンテンツに使用する言語 — アプリの言語と異なる場合があります';

  @override
  String get distanceUnit => '距離の単位';

  @override
  String get temperatureUnit => '気温の単位';

  @override
  String get currencyFormat => '通貨形式';

  @override
  String get km => 'キロメートル';

  @override
  String get miles => 'マイル';

  @override
  String get celsius => '摂氏（°C）';

  @override
  String get fahrenheit => '華氏（°F）';

  @override
  String get systemDefault => 'システムのデフォルト';

  @override
  String get apiKeysTitle => 'APIキー';

  @override
  String get placesNoKeyNote =>
      '検索、周辺スポット、最寄りの空港はOpenStreetMap（Nominatim + Overpass）を利用します — 無料でAPIキーは不要です。';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap APIキー';

  @override
  String get weatherApiKeyDesc => '現在の天気を表示するために必要です。';

  @override
  String get searchApiKeyLabel => 'Tavily検索APIキー（任意）';

  @override
  String get searchApiKeyDesc =>
      'AIが要約する回答を実際の検索結果に基づかせます。設定しない場合、AIは一般知識のみで回答します。';

  @override
  String get llmSettingsTitle => 'AIアシスタント';

  @override
  String get llmEnabled => 'AI要約を有効にする';

  @override
  String get llmEnabledDesc => 'オフにすると、これらの項目はLLMを呼び出す代わりに空欄のままになります';

  @override
  String get byokProviderLabel => 'プロバイダー';

  @override
  String get byokApiKey => 'APIキー';

  @override
  String get byokApiKeyHint => 'この端末にのみ安全に保存されます';

  @override
  String get detailLevel => '詳細レベル';

  @override
  String get detailLevelShort => '簡潔';

  @override
  String get detailLevelDetailed => '詳細';

  @override
  String get showSources => '情報源を表示';

  @override
  String get showSourcesDesc => 'AI要約の根拠となったリンクを表示';

  @override
  String get llmDisclaimer =>
      '「AIによる要約」と表示されたコンテンツは不正確な場合があります。ビザ、健康、安全に関する情報は必ず公式情報源で確認してください。';

  @override
  String get privacySettingsTitle => 'データとプライバシー';

  @override
  String get cacheSize => 'キャッシュサイズ';

  @override
  String get clearCache => 'キャッシュを消去';

  @override
  String get clearCacheConfirm => 'キャッシュされたすべての場所データが削除されます。続行しますか？';

  @override
  String get locationHistory => '場所の履歴';

  @override
  String get clearHistory => '履歴を消去';

  @override
  String get clearHistoryConfirm => '検索履歴が削除されます。続行しますか？';

  @override
  String get gpsPermission => '現在地を使用する';

  @override
  String get gpsPermissionDesc =>
      '半径15km以内の場所を検索するために使用します。いつでも手動での検索に切り替えられます。';

  @override
  String get reducedMotion => 'モーションを減らす';

  @override
  String get reducedMotionDesc => 'ノードグラフの環境アニメーションをオフにする';

  @override
  String get fontSize => 'フォントサイズ';

  @override
  String get historyTitle => '履歴';

  @override
  String get historyEmpty => 'まだ検索した場所がありません。';

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get close => '閉じる';

  @override
  String get groupExplore => '探索';

  @override
  String get groupPractical => '実用情報';

  @override
  String get groupSafety => '安全と健康';

  @override
  String get groupCulture => '文化';

  @override
  String get groupEntryStay => '入国と滞在';
}
