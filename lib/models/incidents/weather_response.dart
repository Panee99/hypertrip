import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/incidents/weather_alerts.dart';
import 'package:room_finder_flutter/models/incidents/weather_current.dart';
import 'package:room_finder_flutter/models/incidents/weather_forecast.dart';
import 'package:room_finder_flutter/models/incidents/weather_location.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse implements Serializable {
  WeatherLocation? location;
  WeatherCurrent? current;
  @JsonKey(name: 'forecast')
  WeatherForecast? foreCast;
  WeatherAlerts? alerts;

  WeatherResponse({this.location, this.current, this.alerts});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
