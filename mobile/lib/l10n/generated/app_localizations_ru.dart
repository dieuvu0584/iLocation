// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Найти место, город или адрес';

  @override
  String get searchButton => 'Поиск';

  @override
  String get searchRecent => 'Недавние';

  @override
  String get searchTryDemo => 'Попробовать демо (Далат)';

  @override
  String get searchNoResults =>
      'Совпадений не найдено. Попробуйте другой запрос.';

  @override
  String get searchError =>
      'Что-то пошло не так. Проверьте подключение или попробуйте демо.';

  @override
  String get searchChooseMatch => 'Выберите место';

  @override
  String get graphBack => 'Назад';

  @override
  String get graphSettings => 'Настройки';

  @override
  String get graphHistory => 'История';

  @override
  String get graphRefresh => 'Обновить';

  @override
  String get graphRefreshAll => 'Обновить всё';

  @override
  String get graphLoading => 'Сбор информации…';

  @override
  String get graphError => 'Не удалось загрузить это место.';

  @override
  String get graphRetry => 'Повторить';

  @override
  String get detailSourceLlm => 'Сводка ИИ';

  @override
  String get detailSourceApi => 'Данные в реальном времени';

  @override
  String get detailSourceStatic => 'Справочные данные';

  @override
  String get detailSourceSearch => 'Необработанные результаты поиска';

  @override
  String get detailSourceMissingKey => 'Нужен API-ключ';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Обновлено $date';
  }

  @override
  String get detailStale =>
      'Показаны более старые кэшированные данные — обновление не удалось';

  @override
  String get detailSources => 'Источники';

  @override
  String get detailNoData => 'Информация пока недоступна.';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguageUnits => 'Язык и единицы измерения';

  @override
  String get settingsLanguageUnitsDesc =>
      'Язык интерфейса, язык контента, единицы расстояния/температуры';

  @override
  String get settingsApiKeys => 'API-ключи';

  @override
  String get settingsApiKeysDesc =>
      'Погода и поиск — для мест/геокодирования ключ не нужен';

  @override
  String get settingsAiAssistant => 'ИИ-помощник';

  @override
  String get settingsAiAssistantDesc =>
      'Ваш собственный API-ключ LLM, уровень детализации, источники';

  @override
  String get settingsDataPrivacy => 'Данные и конфиденциальность';

  @override
  String get settingsDataPrivacyDesc =>
      'Кэш, история, разрешение на геолокацию, анимация, размер шрифта';

  @override
  String get languageSettingsTitle => 'Язык и единицы измерения';

  @override
  String get uiLanguage => 'Язык приложения';

  @override
  String get contentLanguage => 'Язык контента';

  @override
  String get contentLanguageDesc =>
      'Язык, используемый для контента, обобщённого ИИ — может отличаться от языка приложения';

  @override
  String get distanceUnit => 'Единица расстояния';

  @override
  String get temperatureUnit => 'Единица температуры';

  @override
  String get currencyFormat => 'Формат валюты';

  @override
  String get km => 'Километры';

  @override
  String get miles => 'Мили';

  @override
  String get celsius => 'Цельсий (°C)';

  @override
  String get fahrenheit => 'Фаренгейт (°F)';

  @override
  String get systemDefault => 'По умолчанию системы';

  @override
  String get apiKeysTitle => 'API-ключи';

  @override
  String get placesNoKeyNote =>
      'Поиск, места поблизости и ближайший аэропорт работают через OpenStreetMap (Nominatim + Overpass) — бесплатно, API-ключ не нужен.';

  @override
  String get weatherApiKeyLabel => 'API-ключ OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Нужен для текущей погоды.';

  @override
  String get searchApiKeyLabel => 'API-ключ поиска Tavily (необязательно)';

  @override
  String get searchApiKeyDesc =>
      'Позволяет обосновывать ответы ИИ реальными результатами поиска. Без него ИИ отвечает только на основе общих знаний.';

  @override
  String get llmSettingsTitle => 'ИИ-помощник';

  @override
  String get llmEnabled => 'Включить сводки ИИ';

  @override
  String get llmEnabledDesc =>
      'Если выключено, эти элементы остаются пустыми вместо обращения к LLM';

  @override
  String get byokProviderLabel => 'Провайдер';

  @override
  String get byokApiKey => 'API-ключ';

  @override
  String get byokApiKeyHint => 'Хранится безопасно только на этом устройстве';

  @override
  String get detailLevel => 'Уровень детализации';

  @override
  String get detailLevelShort => 'Кратко';

  @override
  String get detailLevelDetailed => 'Подробно';

  @override
  String get showSources => 'Показывать источники';

  @override
  String get showSourcesDesc =>
      'Показывать ссылки, на которых основаны сводки ИИ';

  @override
  String get llmDisclaimer =>
      'Контент с пометкой «Сводка ИИ» может быть неточным. Всегда проверяйте информацию о визах, здоровье и безопасности в официальных источниках.';

  @override
  String get privacySettingsTitle => 'Данные и конфиденциальность';

  @override
  String get cacheSize => 'Размер кэша';

  @override
  String get clearCache => 'Очистить кэш';

  @override
  String get clearCacheConfirm =>
      'Это удалит все кэшированные данные о местах. Продолжить?';

  @override
  String get locationHistory => 'История мест';

  @override
  String get clearHistory => 'Очистить историю';

  @override
  String get clearHistoryConfirm =>
      'Это удалит вашу историю поиска. Продолжить?';

  @override
  String get gpsPermission => 'Использовать моё местоположение';

  @override
  String get gpsPermissionDesc =>
      'Используется для поиска мест в радиусе 15 км от вас. Вы всегда можете искать вручную.';

  @override
  String get reducedMotion => 'Уменьшить анимацию';

  @override
  String get reducedMotionDesc => 'Отключить фоновую анимацию в графе узлов';

  @override
  String get fontSize => 'Размер шрифта';

  @override
  String get historyTitle => 'История';

  @override
  String get historyEmpty => 'Пока нет просмотренных мест.';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get close => 'Закрыть';

  @override
  String get groupExplore => 'Исследовать';

  @override
  String get groupPractical => 'Практическое';

  @override
  String get groupSafety => 'Безопасность и здоровье';

  @override
  String get groupCulture => 'Культура';

  @override
  String get groupEntryStay => 'Въезд и пребывание';
}
