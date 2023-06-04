import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_location.g.dart';

@JsonSerializable()
class WeatherLocation implements Serializable {
  /// Tên địa điểm
  String name;

  /// Tên khu vực hoặc tỉnh.
  String region;

  /// Tên quốc gia
  String country;

  /// Vĩ độ của địa điểm
  double lat;

  /// Kinh độ của địa điểm
  @JsonKey(name: 'lon')
  double lgn;

  /// Mã xác định múi giờ
  @JsonKey(name: 'tz_id')
  String tzId;

  /// Thời gian địa phương (dạng epoch time)
  @JsonKey(name: 'localtime_epoch')
  int localtimeEpoch;

  /// Thời gian địa phương (định dạng ngày/giờ)
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
