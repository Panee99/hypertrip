import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'weather_alert.g.dart';

///"alerts": Chứa thông tin về cảnh báo thời tiết (nếu có).
// "sender_name": Tên nguồn gửi cảnh báo.
// "event": Sự kiện cảnh báo.
// "start": Thời gian bắt đầu cảnh báo (dạng epoch time).
// "end": Thời gian kết thúc cảnh báo (dạng epoch time).
// "description": Mô tả cảnh báo.
// "severity": Mức độ nghiêm trọng của cảnh báo.
// "tags": Các nhãn liên quan đến cảnh báo.

@JsonSerializable()
class WeatherAlert implements Serializable {
  @JsonKey(name: 'sender_name')
  String senderName;
  String event;
  int start;
  int end;
  String description;
  String severity;
  List<String> tags;

  WeatherAlert(
      {this.senderName = '',
      this.event = '',
      this.start = 0,
      this.end = 0,
      this.description = '',
      this.severity = '',
      this.tags = const []});

  factory WeatherAlert.fromJson(Map<String, dynamic> json) => _$WeatherAlertFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeatherAlertToJson(this);
}
