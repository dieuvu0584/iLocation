// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'Location Explorer';

  @override
  String get searchHint => 'Hae paikkaa, kaupunkia tai osoitetta';

  @override
  String get searchButton => 'Hae';

  @override
  String get searchRecent => 'Viimeisimmät';

  @override
  String get searchTryDemo => 'Kokeile esittelyä (Da Lat)';

  @override
  String get searchNoResults => 'Osumia ei löytynyt. Kokeile toista hakua.';

  @override
  String get searchError =>
      'Jokin meni pieleen. Tarkista yhteytesi tai kokeile esittelyä.';

  @override
  String get searchChooseMatch => 'Valitse paikka';

  @override
  String get graphBack => 'Takaisin';

  @override
  String get graphSettings => 'Asetukset';

  @override
  String get graphHistory => 'Historia';

  @override
  String get graphRefresh => 'Päivitä';

  @override
  String get graphRefreshAll => 'Päivitä kaikki';

  @override
  String get graphLoading => 'Kerätään tietoja…';

  @override
  String get graphError => 'Tätä paikkaa ei voitu ladata.';

  @override
  String get graphRetry => 'Yritä uudelleen';

  @override
  String get detailSourceLlm => 'Tekoälyn tiivistämä';

  @override
  String get detailSourceApi => 'Reaaliaikainen data';

  @override
  String get detailSourceStatic => 'Viitetiedot';

  @override
  String get detailSourceSearch => 'Raa\'at hakutulokset';

  @override
  String get detailSourceMissingKey => 'Vaatii API-avaimen';

  @override
  String get detailSourceLink => 'External link';

  @override
  String get openLink => 'Open link';

  @override
  String detailUpdatedAt(String date) {
    return 'Päivitetty $date';
  }

  @override
  String get detailStale =>
      'Näytetään vanhempaa välimuistissa olevaa dataa — päivitys epäonnistui';

  @override
  String get detailSources => 'Lähteet';

  @override
  String get detailNoData => 'Tietoja ei ole vielä saatavilla.';

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get settingsLanguageUnits => 'Kieli ja yksiköt';

  @override
  String get settingsLanguageUnitsDesc =>
      'Sovelluksen kieli, sisällön kieli, etäisyys-/lämpötilayksiköt';

  @override
  String get settingsApiKeys => 'API-avaimet';

  @override
  String get settingsApiKeysDesc =>
      'Sää ja haku — paikat/geokoodaus eivät tarvitse avainta';

  @override
  String get settingsAiAssistant => 'Tekoälyavustaja';

  @override
  String get settingsAiAssistantDesc =>
      'Oma LLM API-avaimesi, tarkkuustaso, lähteet';

  @override
  String get settingsDataPrivacy => 'Tiedot ja tietosuoja';

  @override
  String get settingsDataPrivacyDesc =>
      'Välimuisti, historia, sijaintilupa, liike, fonttikoko';

  @override
  String get languageSettingsTitle => 'Kieli ja yksiköt';

  @override
  String get uiLanguage => 'Sovelluksen kieli';

  @override
  String get contentLanguage => 'Sisällön kieli';

  @override
  String get contentLanguageDesc =>
      'Tekoälyn tiivistämän sisällön kieli — voi poiketa sovelluksen kielestä';

  @override
  String get distanceUnit => 'Etäisyysyksikkö';

  @override
  String get temperatureUnit => 'Lämpötilayksikkö';

  @override
  String get currencyFormat => 'Valuuttamuoto';

  @override
  String get km => 'Kilometriä';

  @override
  String get miles => 'Mailia';

  @override
  String get celsius => 'Celsius (°C)';

  @override
  String get fahrenheit => 'Fahrenheit (°F)';

  @override
  String get systemDefault => 'Järjestelmän oletus';

  @override
  String get apiKeysTitle => 'API-avaimet';

  @override
  String get placesNoKeyNote =>
      'Haku, lähistön paikat ja lähin lentokenttä toimivat OpenStreetMapilla (Nominatim + Overpass) — ilmaiseksi, ilman API-avainta.';

  @override
  String get weatherApiKeyLabel => 'OpenWeatherMap API-avain';

  @override
  String get weatherApiKeyDesc => 'Tarvitaan nykyistä säätä varten.';

  @override
  String get searchApiKeyLabel => 'Tavily-haun API-avain (valinnainen)';

  @override
  String get searchApiKeyDesc =>
      'Perustaa tekoälyn tiivistämät vastaukset todellisiin hakutuloksiin. Ilman sitä tekoäly vastaa vain yleistiedon perusteella.';

  @override
  String get llmSettingsTitle => 'Tekoälyavustaja';

  @override
  String get llmEnabled => 'Ota käyttöön tekoälytiivistelmät';

  @override
  String get llmEnabledDesc =>
      'Kun pois päältä, nämä kohteet jätetään tyhjiksi LLM:n kutsumisen sijaan';

  @override
  String get byokProviderLabel => 'Palveluntarjoaja';

  @override
  String get byokApiKey => 'API-avain';

  @override
  String get byokApiKeyHint =>
      'Tallennetaan turvallisesti vain tälle laitteelle';

  @override
  String get detailLevel => 'Tarkkuustaso';

  @override
  String get detailLevelShort => 'Lyhyt';

  @override
  String get detailLevelDetailed => 'Yksityiskohtainen';

  @override
  String get showSources => 'Näytä lähteet';

  @override
  String get showSourcesDesc =>
      'Näytä linkit, joihin tekoälytiivistelmät perustuivat';

  @override
  String get llmDisclaimer =>
      'Sisältö, joka on merkitty \"Tekoälyn tiivistämä\", voi olla epätarkkaa. Tarkista viisumi-, terveys- ja turvallisuustiedot aina virallisista lähteistä.';

  @override
  String get privacySettingsTitle => 'Tiedot ja tietosuoja';

  @override
  String get cacheSize => 'Välimuistin koko';

  @override
  String get clearCache => 'Tyhjennä välimuisti';

  @override
  String get clearCacheConfirm =>
      'Tämä poistaa kaikki välimuistissa olevat sijaintitiedot. Jatketaanko?';

  @override
  String get locationHistory => 'Sijaintihistoria';

  @override
  String get clearHistory => 'Tyhjennä historia';

  @override
  String get clearHistoryConfirm => 'Tämä poistaa hakuhistoriasi. Jatketaanko?';

  @override
  String get gpsPermission => 'Käytä sijaintiani';

  @override
  String get gpsPermissionDesc =>
      'Käytetään paikkojen löytämiseen 15 km säteellä sinusta. Voit aina hakea manuaalisesti sen sijaan.';

  @override
  String get reducedMotion => 'Vähennä liikettä';

  @override
  String get reducedMotionDesc =>
      'Poista ympäristöanimaatio käytöstä solmukaaviossa';

  @override
  String get fontSize => 'Fonttikoko';

  @override
  String get historyTitle => 'Historia';

  @override
  String get historyEmpty => 'Ei vielä katsottuja paikkoja.';

  @override
  String get save => 'Tallenna';

  @override
  String get cancel => 'Peruuta';

  @override
  String get delete => 'Poista';

  @override
  String get close => 'Sulje';

  @override
  String get groupExplore => 'Tutki';

  @override
  String get groupPractical => 'Käytännöllinen';

  @override
  String get groupSafety => 'Turvallisuus ja terveys';

  @override
  String get groupCulture => 'Kulttuuri';

  @override
  String get groupEntryStay => 'Maahantulo ja oleskelu';
}
