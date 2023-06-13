import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/incidents/weather_condition.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_current.g.dart';

@JsonSerializable()
class WeatherCurrent implements Serializable {
  /// Thời gian cập nhật dữ liệu hiện tại, được đưa ra dưới dạng epoch time
  @JsonKey(name: 'last_updated_epoch')
  int lastUpdatedEpoch;

  /// Thời gian cập nhật dữ liệu hiện tại, được đưa ra dưới dạng ngày và giờ (theo định dạng YYYY-MM-DD HH:mm).
  @JsonKey(name: 'last_updated')
  String lastUpdated;

  /// Nhiệt độ hiện tại theo đơn vị Celsius.
  @JsonKey(name: 'temp_c')
  double tempC;

  /// Nhiệt độ hiện tại theo đơn vị Fahrenheit.
  @JsonKey(name: 'temp_f')
  double tempF;

  /// Chỉ ra liệu hiện tại là ban ngày hay ban đêm (1: ban ngày, 0: ban đêm).
  @JsonKey(name: 'is_day')
  double isDay;

  /// Chứa thông tin về tình trạng thời tiết hiện tại
  WeatherCondition? condition;

  /// Tốc độ gió hiện tại theo đơn vị mph.
  @JsonKey(name: 'wind_mph')
  double windMph;

  /// Tốc độ gió hiện tại theo đơn vị kph.
  @JsonKey(name: 'wind_kph')
  double windKph;

  /// Hướng gió hiện tại trong độ (0-360).
  @JsonKey(name: 'wind_degree')
  int windDegree;

  /// Hướng gió hiện tại dưới dạng văn bản (ví dụ: "SSW").
  @JsonKey(name: 'wind_dir')
  String windDir;

  /// Áp suất không khí hiện tại theo đơn vị millibar.
  @JsonKey(name: 'pressure_mb')
  double pressureMb;

  /// Áp suất không khí hiện tại theo đơn vị inch
  @JsonKey(name: 'pressure_in')
  double pressureIn;

  /// Lượng mưa tích lũy trong 1 giờ qua theo đơn vị milimét
  @JsonKey(name: 'precip_mm')
  double precipMm;

  /// Lượng mưa tích lũy trong 1 giờ qua theo đơn vị inch
  @JsonKey(name: 'precip_in')
  double precipIn;

  /// Độ ẩm hiện tại theo phần trăm.
  int humidity;

  ///  Mây che phủ hiện tại theo phần trăm.
  int cloud;

  /// Nhiệt độ cảm nhận được hiện tại theo đơn vị Celsius.
  @JsonKey(name: 'feelslike_c')
  double feelslikeC;

  /// Nhiệt độ cảm nhận được hiện tại theo đơn vị Fahrenheit.
  @JsonKey(name: 'feelslike_f')
  double feelslikeF;

  /// Tầm nhìn hiện tại theo đơn vị kilômét
  @JsonKey(name: 'vis_km')
  double visKm;

  /// Tầm nhìn hiện tại theo đơn vị dặm
  @JsonKey(name: 'vis_miles')
  double visMiles;

  /// Chỉ số tia tử ngoại hiện tại.
  double uv;

  /// Tốc độ gió giật hiện tại theo đơn vị mph
  @JsonKey(name: 'gust_mph')
  double gustMph;

  /// Tốc độ gió giật hiện tại theo đơn vị kph
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
