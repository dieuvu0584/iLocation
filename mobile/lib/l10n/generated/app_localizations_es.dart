// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Buscar un lugar, ciudad o dirección';

  @override
  String get searchButton => 'Buscar';

  @override
  String get searchRecent => 'Recientes';

  @override
  String get searchTryDemo => 'Probar una demo (Da Lat)';

  @override
  String get searchNoResults =>
      'No se encontraron resultados. Prueba con otra búsqueda.';

  @override
  String get searchError =>
      'Algo salió mal. Comprueba tu conexión o prueba la demo.';

  @override
  String get searchChooseMatch => 'Elige un lugar';

  @override
  String get graphBack => 'Atrás';

  @override
  String get graphSettings => 'Ajustes';

  @override
  String get graphHistory => 'Historial';

  @override
  String get graphRefresh => 'Actualizar';

  @override
  String get graphRefreshAll => 'Actualizar todo';

  @override
  String get graphLoading => 'Recopilando información…';

  @override
  String get graphError => 'No se pudo cargar este lugar.';

  @override
  String get graphRetry => 'Reintentar';

  @override
  String get detailSourceLlm => 'Resumido por IA';

  @override
  String get detailSourceApi => 'Datos en vivo';

  @override
  String get detailSourceStatic => 'Datos de referencia';

  @override
  String get detailSourceSearch => 'Resultados de búsqueda sin procesar';

  @override
  String get detailSourceMissingKey => 'Requiere clave API';

  @override
  String detailUpdatedAt(String date) {
    return 'Actualizado $date';
  }

  @override
  String get detailStale =>
      'Mostrando datos en caché más antiguos — la actualización falló';

  @override
  String get detailSources => 'Fuentes';

  @override
  String get detailNoData => 'Aún no hay información disponible.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsLanguageUnits => 'Idioma y unidades';

  @override
  String get settingsLanguageUnitsDesc =>
      'Idioma de la interfaz, idioma del contenido, unidades de distancia/temperatura';

  @override
  String get settingsApiKeys => 'Claves API';

  @override
  String get settingsApiKeysDesc =>
      'Clima y búsqueda — lugares/geocodificación no necesitan clave';

  @override
  String get settingsAiAssistant => 'Asistente de IA';

  @override
  String get settingsAiAssistantDesc =>
      'Tu propia clave API de LLM, nivel de detalle, fuentes';

  @override
  String get settingsDataPrivacy => 'Datos y privacidad';

  @override
  String get settingsDataPrivacyDesc =>
      'Caché, historial, permiso de ubicación, movimiento, tamaño de fuente';

  @override
  String get languageSettingsTitle => 'Idioma y unidades';

  @override
  String get uiLanguage => 'Idioma de la app';

  @override
  String get contentLanguage => 'Idioma del contenido';

  @override
  String get contentLanguageDesc =>
      'Idioma usado para el contenido resumido por IA — puede diferir del idioma de la app';

  @override
  String get distanceUnit => 'Unidad de distancia';

  @override
  String get temperatureUnit => 'Unidad de temperatura';

  @override
  String get currencyFormat => 'Formato de moneda';

  @override
  String get km => 'Kilómetros';

  @override
  String get miles => 'Millas';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get apiKeysTitle => 'Claves API';

  @override
  String get placesNoKeyNote =>
      'La búsqueda, lugares cercanos y el aeropuerto más cercano funcionan con OpenStreetMap (Nominatim + Overpass) — gratis, sin clave API.';

  @override
  String get weatherApiKeyLabel => 'Clave API de OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Necesaria para el clima actual.';

  @override
  String get searchApiKeyLabel => 'Clave API de búsqueda Tavily (opcional)';

  @override
  String get searchApiKeyDesc =>
      'Basa las respuestas resumidas por IA en resultados de búsqueda reales. Sin ella, la IA responde solo con conocimiento general.';

  @override
  String get llmSettingsTitle => 'Asistente de IA';

  @override
  String get llmEnabled => 'Activar resúmenes de IA';

  @override
  String get llmEnabledDesc =>
      'Cuando está desactivado, esos elementos simplemente quedan en blanco en vez de llamar a un LLM';

  @override
  String get byokProviderLabel => 'Proveedor';

  @override
  String get byokApiKey => 'Clave API';

  @override
  String get byokApiKeyHint =>
      'Guardada de forma segura solo en este dispositivo';

  @override
  String get detailLevel => 'Nivel de detalle';

  @override
  String get detailLevelShort => 'Breve';

  @override
  String get detailLevelDetailed => 'Detallado';

  @override
  String get showSources => 'Mostrar fuentes';

  @override
  String get showSourcesDesc =>
      'Mostrar enlaces en los que se basaron los resúmenes de IA';

  @override
  String get llmDisclaimer =>
      'El contenido marcado como \"Resumido por IA\" puede ser inexacto. Verifica siempre la información de visado, salud y seguridad con fuentes oficiales.';

  @override
  String get privacySettingsTitle => 'Datos y privacidad';

  @override
  String get cacheSize => 'Tamaño de la caché';

  @override
  String get clearCache => 'Borrar caché';

  @override
  String get clearCacheConfirm =>
      'Esto eliminará todos los datos de ubicación en caché. ¿Continuar?';

  @override
  String get locationHistory => 'Historial de ubicaciones';

  @override
  String get clearHistory => 'Borrar historial';

  @override
  String get clearHistoryConfirm =>
      'Esto eliminará tu historial de búsqueda. ¿Continuar?';

  @override
  String get gpsPermission => 'Usar mi ubicación';

  @override
  String get gpsPermissionDesc =>
      'Se usa para encontrar lugares a 15 km de ti. Siempre puedes buscar manualmente en su lugar.';

  @override
  String get reducedMotion => 'Reducir movimiento';

  @override
  String get reducedMotionDesc =>
      'Desactivar la animación ambiental en el grafo de nodos';

  @override
  String get fontSize => 'Tamaño de fuente';

  @override
  String get historyTitle => 'Historial';

  @override
  String get historyEmpty => 'Aún no se ha buscado ningún lugar.';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get close => 'Cerrar';

  @override
  String get groupExplore => 'Explorar';

  @override
  String get groupPractical => 'Práctico';

  @override
  String get groupSafety => 'Seguridad y salud';

  @override
  String get groupCulture => 'Cultura';

  @override
  String get groupEntryStay => 'Entrada y estancia';
}
