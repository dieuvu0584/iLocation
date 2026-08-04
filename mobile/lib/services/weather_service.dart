import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/location_models.dart';

class WeatherException implements Exception {
  final String message;
  WeatherException(this.message);
  @override
  String toString() => message;
}

/// OpenWeatherMap, called directly from the client (BYOK). Structured API
/// only, never touches the LLM.
class WeatherService {
  static const _url = 'https://api.openweathermap.org/data/2.5/weather';

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
    final detail = feelsLike != null ? 'Feels like ${feelsLike.round()}°C, humidity $humidity%, wind $wind m/s' : '';

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
}
