import 'dart:async';
import 'dart:convert';

import 'package:room_finder_flutter/models/incidents/weather_response.dart';
import 'package:room_finder_flutter/utils/network.dart';

class WarningIncidentRepository {
  String weatherKey = 'a79d457fc4c343b0b9a75301230106';
  String weatherApi = 'https://api.weatherapi.com/v1/forecast.json';

  FutureOr<WeatherResponse> fetchDataWeather(
      {int days = 1, double lat = 16.463713, double lng = 107.590866}) async {
    final response = await NetworkUtility.fetchUrl(
        Uri.parse('$weatherApi?key=$weatherKey&q=$lat,$lng&days=$days&aqi=no&alerts=yes'));

    return response != null ? WeatherResponse.fromJson(jsonDecode(response)) : WeatherResponse();
  }
}
