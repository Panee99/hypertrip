import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_condition.g.dart';

///"condition": Điều kiện thời tiết hiện tại.
// "text": Mô tả văn bản về điều kiện thời tiết.
// "icon": URL đến biểu tượng biểu thị điều kiện thời tiết.

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
