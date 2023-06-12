import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/incidents/weather_condition.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_current.g.dart';

@JsonSerializable()
class WeatherCurrent implements Serializable {
  @JsonKey(name: 'last_updated_epoch')
  int lastUpdatedEpoch;
  @JsonKey(name: 'last_updated')
  String lastUpdated;
  @JsonKey(name: 'temp_c')
  double tempC;
  @JsonKey(name: 'temp_f')
  double tempF;
  @JsonKey(name: 'is_day')
  double isDay;
  WeatherCondition? condition;
  @JsonKey(name: 'wind_mph')
  double windMph;
  @JsonKey(name: 'wind_kph')
  double windKph;
  @JsonKey(name: 'wind_degree')
  int windDegree;
  @JsonKey(name: 'wind_dir')
  String windDir;
  @JsonKey(name: 'pressure_mb')
  double pressureMb;
  @JsonKey(name: 'pressure_in')
  double pressureIn;
  @JsonKey(name: 'precip_mm')
  double precipMm;
  @JsonKey(name: 'precip_in')
  double precipIn;
  int humidity;
  int cloud;
  @JsonKey(name: 'feelslike_c')
  double feelslikeC;
  @JsonKey(name: 'feelslike_f')
  double feelslikeF;
  @JsonKey(name: 'vis_km')
  double visKm;
  @JsonKey(name: 'vis_miles')
  double visMiles;
  double uv;
  @JsonKey(name: 'gust_mph')
  double gustMph;
  @JsonKey(name: 'gust_kph')
  double gustKph;

  WeatherCurrent({
    this.lastUpdatedEpoch = 0,
    this.lastUpdated = '',
    this.tempC = 0.0,
    this.tempF = 0.0,
    this.isDay = 1,
    this.condition,
    this.windMph = 0.0,
    this.windKph = 0.0,
    this.windDegree = 0,
    this.windDir = '',
    this.pressureMb = 0.0,
    this.pressureIn = 0.0,
    this.precipMm = 0.0,
    this.precipIn = 0.0,
    this.humidity = 0,
    this.cloud = 0,
    this.feelslikeC = 0.0,
    this.feelslikeF = 0.0,
    this.visKm = 0.0,
    this.visMiles = 0.0,
    this.uv = 0.0,
    this.gustMph = 0.0,
    this.gustKph = 0.0,
  });

  factory WeatherCurrent.fromJson(Map<String, dynamic> json) => _$WeatherCurrentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherCurrentToJson(this);
}
