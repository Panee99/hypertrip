import 'package:equatable/equatable.dart';
import 'package:room_finder_flutter/models/incidents/earth_quakes_response.dart';
import 'package:room_finder_flutter/models/incidents/weather_response.dart';

abstract class WarningIncidentState extends Equatable {
  final WeatherResponse? weatherResponse;
  final EarthquakesResponse? earthquakesResponse;
  final String error;

  WarningIncidentState(
      {required this.error, required this.weatherResponse, required this.earthquakesResponse});

  WarningIncidentState copyWith(
      {String? error, WeatherResponse? weatherResponse, EarthquakesResponse? earthquakesResponse}) {
    return WeatherLoadedState(
      error: error ?? this.error,
      weatherResponse: weatherResponse ?? this.weatherResponse,
      earthquakesResponse: earthquakesResponse ?? this.earthquakesResponse,
    );
  }
}

class WeatherLoadingState extends WarningIncidentState {
  WeatherLoadingState(
      {required super.weatherResponse, required super.earthquakesResponse, required super.error});

  @override
  List<Object?> get props => [weatherResponse];
}

class WeatherLoadedState extends WarningIncidentState {
  WeatherLoadedState(
      {required super.weatherResponse, required super.earthquakesResponse, required super.error});

  @override
  List<Object?> get props => [earthquakesResponse];
}

class WeatherErrorState extends WarningIncidentState {
  WeatherErrorState(
      {required super.error, required super.weatherResponse, required super.earthquakesResponse});

  @override
  List<Object?> get props => [error];
}
