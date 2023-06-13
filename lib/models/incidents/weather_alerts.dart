import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/incidents/weather_alert.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_alerts.g.dart';

@JsonSerializable()
class WeatherAlerts implements Serializable {
  List<WeatherAlert> alert;

  WeatherAlerts({this.alert = const []});

  factory WeatherAlerts.fromJson(Map<String, dynamic> json) => _$WeatherAlertsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherAlertsToJson(this);
}
