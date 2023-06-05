import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'recent_message.g.dart';

@JsonSerializable()
class RecentMessage implements Serializable {
  /// Nội dung cuối cùng được gửi lên
  String message;

  /// Thởi gian gửi lên
  @JsonKey(name: 'send_at')
  DateTime sendAt;

  /// Ai đã đọc, dựa vào các userId tồn tại trong mãng để kiểm tra ai đã xem và chưa xem
  List<String> readBy;

  RecentMessage({this.message = '', required this.sendAt, this.readBy = const []});

  factory RecentMessage.fromJson(Map<String, dynamic> json) => _$RecentMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecentMessageToJson(this);
}
