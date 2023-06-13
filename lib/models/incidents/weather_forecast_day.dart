import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/incidents/weather_hour.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_forecast_day.g.dart';

@JsonSerializable()
class WeatherForecastDay implements Serializable {
  /// Dữ liệu dự báo từng giờ
  @JsonKey(name: 'hour')
  List<WeatherHour> hours;

  WeatherForecastDay({this.hours = const []});

  factory WeatherForecastDay.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastDayFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherForecastDayToJson(this);
}
