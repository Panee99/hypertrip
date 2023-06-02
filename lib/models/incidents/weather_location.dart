import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_location.g.dart';

@JsonSerializable()
class WeatherLocation implements Serializable {
  String name;
  String region;
  String country;
  double lat;
  @JsonKey(name: 'lon')
  double lgn;
  @JsonKey(name: 'tz_id')
  String tzId;
  @JsonKey(name: 'localtime_epoch')
  int localtimeEpoch;
  String localtime;

  WeatherLocation({
    this.name = '',
    this.region = '',
    this.country = '',
    this.lat = 0.0,
    this.lgn = 0.0,
    this.tzId = '',
    this.localtimeEpoch = 0,
    this.localtime = '',
  });

  factory WeatherLocation.fromJson(Map<String, dynamic> json) => _$WeatherLocationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherLocationToJson(this);
}
