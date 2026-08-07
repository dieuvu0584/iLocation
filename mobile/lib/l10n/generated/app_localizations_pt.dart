// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Pesquisar um lugar, cidade ou endereço';

  @override
  String get searchButton => 'Pesquisar';

  @override
  String get searchRecent => 'Recentes';

  @override
  String get searchTryDemo => 'Experimentar uma demo (Da Lat)';

  @override
  String get searchNoResults =>
      'Nenhum resultado encontrado. Tente outra pesquisa.';

  @override
  String get searchError =>
      'Algo deu errado. Verifique sua conexão ou experimente a demo.';

  @override
  String get searchChooseMatch => 'Escolha um lugar';

  @override
  String get graphBack => 'Voltar';

  @override
  String get graphSettings => 'Configurações';

  @override
  String get graphHistory => 'Histórico';

  @override
  String get graphRefresh => 'Atualizar';

  @override
  String get graphRefreshAll => 'Atualizar tudo';

  @override
  String get graphLoading => 'Reunindo informações…';

  @override
  String get graphError => 'Não foi possível carregar este lugar.';

  @override
  String get graphRetry => 'Tentar novamente';

  @override
  String get detailSourceLlm => 'Resumido por IA';

  @override
  String get detailSourceApi => 'Dados em tempo real';

  @override
  String get detailSourceStatic => 'Dados de referência';

  @override
  String get detailSourceSearch => 'Resultados de pesquisa brutos';

  @override
  String get detailSourceMissingKey => 'Requer chave de API';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String get getApiKeyLink => 'Get an API key';

  @override
  String detailUpdatedAt(String date) {
    return 'Atualizado em $date';
  }

  @override
  String get detailStale =>
      'Exibindo dados em cache mais antigos — a atualização falhou';

  @override
  String get detailSources => 'Fontes';

  @override
  String get detailNoData => 'Ainda não há informações disponíveis.';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLanguageUnits => 'Idioma e unidades';

  @override
  String get settingsLanguageUnitsDesc =>
      'Idioma da interface, idioma do conteúdo, unidades de distância/temperatura';

  @override
  String get settingsApiKeys => 'Chaves de API';

  @override
  String get settingsApiKeysDesc =>
      'Clima e pesquisa — lugares/geocodificação não precisam de chave';

  @override
  String get settingsAiAssistant => 'Assistente de IA';

  @override
  String get settingsAiAssistantDesc =>
      'Sua própria chave de API LLM, nível de detalhe, fontes';

  @override
  String get settingsDataPrivacy => 'Dados e privacidade';

  @override
  String get settingsDataPrivacyDesc =>
      'Cache, histórico, permissão de localização, movimento, tamanho da fonte';

  @override
  String get languageSettingsTitle => 'Idioma e unidades';

  @override
  String get uiLanguage => 'Idioma do app';

  @override
  String get contentLanguage => 'Idioma do conteúdo';

  @override
  String get contentLanguageDesc =>
      'Idioma usado para o conteúdo resumido por IA — pode ser diferente do idioma do app';

  @override
  String get distanceUnit => 'Unidade de distância';

  @override
  String get temperatureUnit => 'Unidade de temperatura';

  @override
  String get currencyFormat => 'Formato de moeda';

  @override
  String get km => 'Quilômetros';

  @override
  String get miles => 'Milhas';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get apiKeysTitle => 'Chaves de API';

  @override
  String get placesNoKeyNote =>
      'Pesquisa, lugares próximos e o aeroporto mais próximo usam OpenStreetMap (Nominatim + Overpass) — grátis, sem necessidade de chave de API.';

  @override
  String get weatherApiKeyLabel => 'Chave de API do OpenWeatherMap';

  @override
  String get weatherApiKeyDesc => 'Necessária para o clima atual.';

  @override
  String get searchApiKeyLabel => 'Chave de API de pesquisa Tavily (opcional)';

  @override
  String get searchApiKeyDesc =>
      'Baseia as respostas resumidas por IA em resultados de pesquisa reais. Sem ela, a IA responde apenas com conhecimento geral.';

  @override
  String get llmSettingsTitle => 'Assistente de IA';

  @override
  String get llmEnabled => 'Ativar resumos de IA';

  @override
  String get llmEnabledDesc =>
      'Quando desativado, esses itens ficam simplesmente em branco em vez de chamar um LLM';

  @override
  String get byokProviderLabel => 'Provedor';

  @override
  String get byokApiKey => 'Chave de API';

  @override
  String get byokApiKeyHint =>
      'Armazenada com segurança apenas neste dispositivo';

  @override
  String get llmKeyBuiltIn =>
      'This provider uses a shared key built into the app — no key needed.';

  @override
  String get detailLevel => 'Nível de detalhe';

  @override
  String get detailLevelShort => 'Breve';

  @override
  String get detailLevelDetailed => 'Detalhado';

  @override
  String get showSources => 'Mostrar fontes';

  @override
  String get showSourcesDesc =>
      'Exibir links em que os resumos de IA se basearam';

  @override
  String get llmDisclaimer =>
      'Conteúdo marcado como \"Resumido por IA\" pode ser impreciso. Sempre verifique informações de visto, saúde e segurança com fontes oficiais.';

  @override
  String get privacySettingsTitle => 'Dados e privacidade';

  @override
  String get cacheSize => 'Tamanho do cache';

  @override
  String get clearCache => 'Limpar cache';

  @override
  String get clearCacheConfirm =>
      'Isso removerá todos os dados de locais em cache. Continuar?';

  @override
  String get locationHistory => 'Histórico de locais';

  @override
  String get clearHistory => 'Limpar histórico';

  @override
  String get clearHistoryConfirm =>
      'Isso removerá seu histórico de pesquisa. Continuar?';

  @override
  String get gpsPermission => 'Usar minha localização';

  @override
  String get gpsPermissionDesc =>
      'Usado para encontrar lugares a até 15 km de você. Você sempre pode pesquisar manualmente em vez disso.';

  @override
  String get reducedMotion => 'Reduzir movimento';

  @override
  String get reducedMotionDesc =>
      'Desativar a animação ambiente no grafo de nós';

  @override
  String get fontSize => 'Tamanho da fonte';

  @override
  String get historyTitle => 'Histórico';

  @override
  String get historyEmpty => 'Nenhum local pesquisado ainda.';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get close => 'Fechar';

  @override
  String get groupExplore => 'Explorar';

  @override
  String get groupPractical => 'Prático';

  @override
  String get groupSafety => 'Segurança e saúde';

  @override
  String get groupCulture => 'Cultura';

  @override
  String get groupEntryStay => 'Entrada e estadia';
}
