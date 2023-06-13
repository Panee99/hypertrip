import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/incidents/weather_forecast_day.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_forecast.g.dart';

@JsonSerializable()
class WeatherForecast implements Serializable {
  @JsonKey(name: 'forecastday')
  List<WeatherForecastDay> forecastDay;

  WeatherForecast({this.forecastDay = const []});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) => _$WeatherForecastFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);
}
