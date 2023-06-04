import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_condition.g.dart';

@JsonSerializable()
class WeatherCondition implements Serializable {
  /// Mô tả văn bản về điều kiện thời tiết.
  String text;

  /// Đường dẫn đến biểu tượng thời tiết hiện tại.
  String icon;

  /// Mã số đại diện cho tình trạng thời tiết hiện tại.
  int code;

  WeatherCondition({this.text = '', this.icon = '', this.code = 0});

  factory WeatherCondition.fromJson(Map<String, dynamic> json) => _$WeatherConditionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherConditionToJson(this);
}
