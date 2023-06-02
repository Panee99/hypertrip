import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/incidents/weather_condition.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_hour.g.dart';

@JsonSerializable()
class WeatherHour implements Serializable {
  @JsonKey(name: 'time_epoch')
  int timeEpoch;
  String time;
  @JsonKey(name: 'temp_c')
  double tempC;
  @JsonKey(name: 'temp_f')
  double tempF;
  @JsonKey(name: 'is_day')
  int isDay;
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
  @JsonKey(name: 'windchill_c')
  double windchillC;
  @JsonKey(name: 'windchill_f')
  double windchillF;
  @JsonKey(name: 'heatindex_c')
  double heatindexC;
  @JsonKey(name: 'heatindex_f')
  double heatindexF;
  @JsonKey(name: 'dewpoint_c')
  double dewpointC;
  @JsonKey(name: 'dewpoint_f')
  double dewpointF;
  @JsonKey(name: 'will_it_rain')
  int willItRain;
  @JsonKey(name: 'chance_of_rain')
  int chanceOfRain;
  @JsonKey(name: 'will_it_snow')
  int willItSnow;
  @JsonKey(name: 'chance_of_snow')
  int chanceOfSnow;
  @JsonKey(name: 'vis_km')
  double visKm;
  @JsonKey(name: 'vis_miles')
  double visMiles;
  @JsonKey(name: 'gust_mph')
  double gustMph;
  @JsonKey(name: 'gust_kph')
  double gustKph;
  double uv;

  WeatherHour({
    this.timeEpoch = 0,
    this.time = '',
    this.tempC = 0.0,
    this.tempF = 0.0,
    this.isDay = 0,
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
    this.windchillC = 0.0,
    this.windchillF = 0.0,
    this.heatindexC = 0.0,
    this.heatindexF = 0.0,
    this.dewpointC = 0.0,
    this.dewpointF = 0.0,
    this.willItRain = 0,
    this.chanceOfRain = 0,
    this.willItSnow = 0,
    this.chanceOfSnow = 0,
    this.visKm = 0.0,
    this.visMiles = 0.0,
    this.gustMph = 0.0,
    this.gustKph = 0.0,
    this.uv = 0.0,
  });

  factory WeatherHour.fromJson(Map<String, dynamic> json) => _$WeatherHourFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherHourToJson(this);
}
