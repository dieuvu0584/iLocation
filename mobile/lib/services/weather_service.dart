import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/location_models.dart';

class WeatherException implements Exception {
  final String message;
  WeatherException(this.message);
  @override
  String toString() => message;
}

/// Maps WMO weather codes (used by Open-Meteo) to a short human label.
/// https://open-meteo.com/en/docs — "WMO Weather interpretation codes".
const Map<int, String> _wmoWeatherLabels = {
  0: 'clear',
  1: 'mostly clear',
  2: 'partly cloudy',
  3: 'overcast',
  45: 'fog',
  48: 'fog',
  51: 'light drizzle',
  53: 'drizzle',
  55: 'heavy drizzle',
  56: 'freezing drizzle',
  57: 'freezing drizzle',
  61: 'light rain',
  63: 'rain',
  65: 'heavy rain',
  66: 'freezing rain',
  67: 'freezing rain',
  71: 'light snow',
  73: 'snow',
  75: 'heavy snow',
  77: 'snow grains',
  80: 'rain showers',
  81: 'rain showers',
  82: 'violent rain showers',
  85: 'snow showers',
  86: 'heavy snow showers',
  95: 'thunderstorm',
  96: 'thunderstorm with hail',
  99: 'thunderstorm with hail',
};

/// OpenWeatherMap for current conditions (BYOK), plus a 7-day forecast from
/// Open-Meteo — free, no API key, matching the project's preference for
/// no-key providers wherever one exists (CLAUDE.md: Nominatim/Overpass are
/// already this way). Forecast is best-effort: if it fails, the current
/// conditions still stand on their own rather than losing the whole item.
class WeatherService {
  static const _url = 'https://api.openweathermap.org/data/2.5/weather';
  static const _forecastUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<ChildItem> getWeather(double lat, double lng, String apiKey) async {
    final uri = Uri.parse(_url).replace(queryParameters: {
      'lat': '$lat',
      'lon': '$lng',
      'appid': apiKey,
      'units': 'metric',
    });
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw WeatherException('Weather request failed (${resp.statusCode})');
    }
    final data = jsonDecode(resp.body) as Map<String, dynamic>;

    final main = data['main'] as Map<String, dynamic>? ?? {};
    final tempC = (main['temp'] as num?)?.toDouble();
    final feelsLike = (main['feels_like'] as num?)?.toDouble();
    final humidity = main['humidity'];
    final wind = (data['wind'] as Map<String, dynamic>?)?['speed'];
    final weatherList = data['weather'] as List<dynamic>? ?? [];
    final condition = weatherList.isNotEmpty
        ? (weatherList.first as Map<String, dynamic>)['description'] as String? ?? 'unknown'
        : 'unknown';

    final summary = tempC != null ? '${tempC.round()}°C, $condition' : condition;
    var detail = feelsLike != null ? 'Feels like ${feelsLike.round()}°C, humidity $humidity%, wind $wind m/s' : '';

    final forecast = await _getSevenDayForecast(lat, lng);
    if (forecast != null) {
      detail = detail.isEmpty ? forecast : '$detail\n\n$forecast';
    }

    return ChildItem(
      id: 'weather',
      label: kChildLabels['weather']!,
      source: 'api',
      summary: summary,
      detail: detail,
      sources: const [],
      updatedAt: DateTime.now().toUtc(),
    );
  }

  Future<String?> _getSevenDayForecast(double lat, double lng) async {
    try {
      final uri = Uri.parse(_forecastUrl).replace(queryParameters: {
        'latitude': '$lat',
        'longitude': '$lng',
        'daily': 'weather_code,temperature_2m_max,temperature_2m_min',
        'timezone': 'auto',
        'forecast_days': '7',
      });
      final resp = await http.get(uri);
      if (resp.statusCode != 200) return null;
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final daily = data['daily'] as Map<String, dynamic>?;
      if (daily == null) return null;

      final dates = (daily['time'] as List<dynamic>? ?? []).cast<String>();
      final codes = (daily['weather_code'] as List<dynamic>? ?? daily['weathercode'] as List<dynamic>? ?? []);
      final highs = (daily['temperature_2m_max'] as List<dynamic>? ?? []);
      final lows = (daily['temperature_2m_min'] as List<dynamic>? ?? []);
      if (dates.isEmpty) return null;

      final lines = <String>['7-day forecast:'];
      for (var i = 0; i < dates.length; i++) {
        final day = DateTime.tryParse(dates[i]);
        final dayLabel = day != null ? _weekdayShort(day.weekday) : dates[i];
        final code = i < codes.length ? (codes[i] as num?)?.toInt() : null;
        final condition = code != null ? (_wmoWeatherLabels[code] ?? 'n/a') : 'n/a';
        final high = i < highs.length ? (highs[i] as num?)?.round() : null;
        final low = i < lows.length ? (lows[i] as num?)?.round() : null;
        final temps = (high != null && low != null) ? '$high°/$low°C' : '';
        lines.add('$dayLabel: $temps $condition'.trim());
      }
      return lines.join('\n');
    } catch (_) {
      return null;
    }
  }

  String _weekdayShort(int weekday) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[(weekday - 1).clamp(0, 6)];
  }
}
