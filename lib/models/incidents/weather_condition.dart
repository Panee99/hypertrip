import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_condition.g.dart';

@JsonSerializable()
class WeatherCondition implements Serializable {
  String text;
  String icon;
  int code;

  WeatherCondition({this.text = '', this.icon = '', this.code = 0});

  factory WeatherCondition.fromJson(Map<String, dynamic> json) => _$WeatherConditionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherConditionToJson(this);
}
