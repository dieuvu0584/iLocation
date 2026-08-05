// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Знайти місце, місто або адресу';

  @override
  String get searchButton => 'Пошук';

  @override
  String get searchRecent => 'Нещодавні';

  @override
  String get searchTryDemo => 'Спробувати демо (Далат)';

  @override
  String get searchNoResults => 'Збігів не знайдено. Спробуйте інший пошук.';

  @override
  String get searchError =>
      'Щось пішло не так. Перевірте з\'єднання або спробуйте демо.';

  @override
  String get searchChooseMatch => 'Виберіть місце';

  @override
  String get graphBack => 'Назад';

  @override
  String get graphSettings => 'Налаштування';

  @override
  String get graphHistory => 'Історія';

  @override
  String get graphRefresh => 'Оновити';

  @override
  String get graphRefreshAll => 'Оновити все';

  @override
  String get graphLoading => 'Збір інформації…';

  @override
  String get graphError => 'Не вдалося завантажити це місце.';

  @override
  String get graphRetry => 'Повторити';

  @override
  String get detailSourceLlm => 'Резюме ШІ';

  @override
  String get detailSourceApi => 'Дані в реальному часі';

  @override
  String get detailSourceStatic => 'Довідкові дані';

  @override
  String get detailSourceSearch => 'Необроблені результати пошуку';

  @override
  String get detailSourceMissingKey => 'Потрібен ключ API';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Оновлено $date';
  }

  @override
  String get detailStale =>
      'Показано старіші кешовані дані — оновлення не вдалося';

  @override
  String get detailSources => 'Джерела';

  @override
  String get detailNoData => 'Інформація поки що недоступна.';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get settingsLanguageUnits => 'Мова та одиниці';

  @override
  String get settingsLanguageUnitsDesc =>
      'Мова інтерфейсу, мова вмісту, одиниці відстані/температури';

  @override
  String get settingsApiKeys => 'Ключі API';

  @override
  String get settingsApiKeysDesc =>
      'Погода та пошук — для місць/геокодування ключ не потрібен';

  @override
  String get settingsAiAssistant => 'ШІ-помічник';

  @override
  String get settingsAiAssistantDesc =>
      'Ваш власний ключ API LLM, рівень деталізації, джерела';

  @override
  String get settingsDataPrivacy => 'Дані та конфіденційність';

  @override
  String get settingsDataPrivacyDesc =>
      'Кеш, історія, дозвіл на геолокацію, анімація, розмір шрифту';

  @override
  String get languageSettingsTitle => 'Мова та одиниці';

  @override
  String get uiLanguage => 'Мова застосунку';

  @override
  String get contentLanguage => 'Мова вмісту';

  @override
  String get contentLanguageDesc =>
      'Мова, яка використовується для вмісту, узагальненого ШІ — може відрізнятися від мови застосунку';

  @override
  String get distanceUnit => 'Одиниця відстані';

  @override
  String get temperatureUnit => 'Одиниця температури';

  @override
  String get currencyFormat => 'Формат валюти';

  @override
  String get km => 'Кілометри';

  @override
  String get miles => 'Милі';

  @override
  String get celsius => 'Цельсій (°C)';

  @override
  String get fahrenheit => 'Фаренгейт (°F)';

  @override
  String get systemDefault => 'За замовчуванням системи';

  @override
  String get apiKeysTitle => 'Ключі API';

  @override
  String get placesNoKeyNote =>
      'Пошук, місця поблизу та найближчий аеропорт працюють через OpenStreetMap (Nominatim + Overpass) — безкоштовно, ключ API не потрібен.';

  @override
  String get weatherApiKeyLabel => 'Ключ API OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Потрібен для поточної погоди.';

  @override
  String get searchApiKeyLabel => 'Ключ API пошуку Tavily (необов\'язково)';

  @override
  String get searchApiKeyDesc =>
      'Обґрунтовує відповіді, узагальнені ШІ, реальними результатами пошуку. Без нього ШІ відповідає лише на основі загальних знань.';

  @override
  String get llmSettingsTitle => 'ШІ-помічник';

  @override
  String get llmEnabled => 'Увімкнути резюме ШІ';

  @override
  String get llmEnabledDesc =>
      'Якщо вимкнено, ці елементи просто залишаються порожніми замість виклику LLM';

  @override
  String get byokProviderLabel => 'Провайдер';

  @override
  String get byokApiKey => 'Ключ API';

  @override
  String get byokApiKeyHint => 'Безпечно зберігається лише на цьому пристрої';

  @override
  String get detailLevel => 'Рівень деталізації';

  @override
  String get detailLevelShort => 'Коротко';

  @override
  String get detailLevelDetailed => 'Детально';

  @override
  String get showSources => 'Показати джерела';

  @override
  String get showSourcesDesc =>
      'Показати посилання, на яких базувалися резюме ШІ';

  @override
  String get llmDisclaimer =>
      'Вміст, позначений як \"Резюме ШІ\", може бути неточним. Завжди перевіряйте інформацію про візу, здоров\'я та безпеку в офіційних джерелах.';

  @override
  String get privacySettingsTitle => 'Дані та конфіденційність';

  @override
  String get cacheSize => 'Розмір кешу';

  @override
  String get clearCache => 'Очистити кеш';

  @override
  String get clearCacheConfirm =>
      'Це видалить усі кешовані дані про місця. Продовжити?';

  @override
  String get locationHistory => 'Історія місць';

  @override
  String get clearHistory => 'Очистити історію';

  @override
  String get clearHistoryConfirm =>
      'Це видалить вашу історію пошуку. Продовжити?';

  @override
  String get gpsPermission => 'Використовувати моє місцезнаходження';

  @override
  String get gpsPermissionDesc =>
      'Використовується для пошуку місць у радіусі 15 км від вас. Ви завжди можете шукати вручну.';

  @override
  String get reducedMotion => 'Зменшити анімацію';

  @override
  String get reducedMotionDesc => 'Вимкнути фонову анімацію в графі вузлів';

  @override
  String get fontSize => 'Розмір шрифту';

  @override
  String get historyTitle => 'Історія';

  @override
  String get historyEmpty => 'Ще жодного місця не переглянуто.';

  @override
  String get save => 'Зберегти';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get close => 'Закрити';

  @override
  String get groupExplore => 'Дослідити';

  @override
  String get groupPractical => 'Практичне';

  @override
  String get groupSafety => 'Безпека та здоров\'я';

  @override
  String get groupCulture => 'Культура';

  @override
  String get groupEntryStay => 'В\'їзд і перебування';
}
