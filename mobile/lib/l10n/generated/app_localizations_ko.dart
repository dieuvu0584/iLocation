// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => '장소, 도시 또는 주소 검색';

  @override
  String get searchButton => '검색';

  @override
  String get searchRecent => '최근 검색';

  @override
  String get searchTryDemo => '데모 사용해보기 (달랏)';

  @override
  String get searchNoResults => '일치하는 결과가 없습니다. 다른 검색어를 시도해 보세요.';

  @override
  String get searchError => '문제가 발생했습니다. 연결 상태를 확인하거나 데모를 사용해 보세요.';

  @override
  String get searchChooseMatch => '장소 선택';

  @override
  String get graphBack => '뒤로';

  @override
  String get graphSettings => '설정';

  @override
  String get graphHistory => '기록';

  @override
  String get graphRefresh => '새로고침';

  @override
  String get graphRefreshAll => '전체 새로고침';

  @override
  String get graphLoading => '정보를 수집하는 중…';

  @override
  String get graphError => '이 장소를 불러올 수 없습니다.';

  @override
  String get graphRetry => '다시 시도';

  @override
  String get detailSourceLlm => 'AI 요약';

  @override
  String get detailSourceApi => '실시간 데이터';

  @override
  String get detailSourceStatic => '참고 데이터';

  @override
  String get detailSourceSearch => '원본 검색 결과';

  @override
  String get detailSourceMissingKey => 'API 키가 필요합니다';

  @override
  String detailUpdatedAt(String date) {
    return '$date에 업데이트됨';
  }

  @override
  String get detailStale => '이전 캐시 데이터를 표시 중 — 새로고침 실패';

  @override
  String get detailSources => '출처';

  @override
  String get detailNoData => '아직 사용 가능한 정보가 없습니다.';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsLanguageUnits => '언어 및 단위';

  @override
  String get settingsLanguageUnitsDesc => '앱 언어, 콘텐츠 언어, 거리/온도 단위';

  @override
  String get settingsApiKeys => 'API 키';

  @override
  String get settingsApiKeysDesc => '날씨 및 검색 — 장소/지오코딩에는 키가 필요하지 않음';

  @override
  String get settingsAiAssistant => 'AI 어시스턴트';

  @override
  String get settingsAiAssistantDesc => '본인 소유의 LLM API 키, 세부 수준, 출처';

  @override
  String get settingsDataPrivacy => '데이터 및 개인정보 보호';

  @override
  String get settingsDataPrivacyDesc => '캐시, 기록, 위치 권한, 모션, 글꼴 크기';

  @override
  String get languageSettingsTitle => '언어 및 단위';

  @override
  String get uiLanguage => '앱 언어';

  @override
  String get contentLanguage => '콘텐츠 언어';

  @override
  String get contentLanguageDesc => 'AI 요약 콘텐츠에 사용되는 언어 — 앱 언어와 다를 수 있습니다';

  @override
  String get distanceUnit => '거리 단위';

  @override
  String get temperatureUnit => '온도 단위';

  @override
  String get currencyFormat => '통화 형식';

  @override
  String get km => '킬로미터';

  @override
  String get miles => '마일';

  @override
  String get celsius => '섭씨 (°C)';

  @override
  String get fahrenheit => '화씨 (°F)';

  @override
  String get systemDefault => '시스템 기본값';

  @override
  String get apiKeysTitle => 'API 키';

  @override
  String get placesNoKeyNote =>
      '검색, 주변 장소, 가장 가까운 공항 정보는 OpenStreetMap(Nominatim + Overpass)을 사용합니다 — 무료이며 API 키가 필요하지 않습니다.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API 키';

  @override
  String get weatherApiKeyDesc => '현재 날씨를 표시하는 데 필요합니다.';

  @override
  String get searchApiKeyLabel => 'Tavily 검색 API 키 (선택 사항)';

  @override
  String get searchApiKeyDesc =>
      'AI 요약 답변을 실제 검색 결과에 기반하도록 합니다. 없으면 AI는 일반 지식만으로 답변합니다.';

  @override
  String get llmSettingsTitle => 'AI 어시스턴트';

  @override
  String get llmEnabled => 'AI 요약 사용';

  @override
  String get llmEnabledDesc => '비활성화하면 LLM을 호출하는 대신 해당 항목이 비워집니다';

  @override
  String get byokProviderLabel => '제공업체';

  @override
  String get byokApiKey => 'API 키';

  @override
  String get byokApiKeyHint => '이 기기에만 안전하게 저장됩니다';

  @override
  String get detailLevel => '세부 수준';

  @override
  String get detailLevelShort => '간단히';

  @override
  String get detailLevelDetailed => '자세히';

  @override
  String get showSources => '출처 표시';

  @override
  String get showSourcesDesc => 'AI 요약의 근거가 된 링크 표시';

  @override
  String get llmDisclaimer =>
      '\"AI 요약\"으로 표시된 콘텐츠는 부정확할 수 있습니다. 비자, 건강, 안전 정보는 항상 공식 출처에서 확인하세요.';

  @override
  String get privacySettingsTitle => '데이터 및 개인정보 보호';

  @override
  String get cacheSize => '캐시 크기';

  @override
  String get clearCache => '캐시 지우기';

  @override
  String get clearCacheConfirm => '캐시된 모든 위치 데이터가 삭제됩니다. 계속하시겠습니까?';

  @override
  String get locationHistory => '위치 기록';

  @override
  String get clearHistory => '기록 지우기';

  @override
  String get clearHistoryConfirm => '검색 기록이 삭제됩니다. 계속하시겠습니까?';

  @override
  String get gpsPermission => '내 위치 사용';

  @override
  String get gpsPermissionDesc =>
      '주변 15km 이내의 장소를 찾는 데 사용됩니다. 언제든지 수동으로 검색할 수도 있습니다.';

  @override
  String get reducedMotion => '모션 줄이기';

  @override
  String get reducedMotionDesc => '노드 그래프의 배경 애니메이션 끄기';

  @override
  String get fontSize => '글꼴 크기';

  @override
  String get historyTitle => '기록';

  @override
  String get historyEmpty => '아직 조회한 장소가 없습니다.';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get close => '닫기';

  @override
  String get groupExplore => '탐색';

  @override
  String get groupPractical => '실용 정보';

  @override
  String get groupSafety => '안전 및 건강';

  @override
  String get groupCulture => '문화';

  @override
  String get groupEntryStay => '입국 및 체류';
}
