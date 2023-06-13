import 'package:chatview/chatview.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'firestore_message.g.dart';

@JsonSerializable()
class FirestoreMessage implements Serializable {
  @JsonKey(name: 'SenderId')
  String? senderId;
  @JsonKey(name: 'Type', fromJson: _enumFromJson, toJson: _enumToJson)
  MessageType type;
  @JsonKey(name: 'Content')
  String content;

  /// UID người gửi
  @JsonKey(name: 'Timestamp')
  DateTime timestamp;

  FirestoreMessage(
      {this.senderId, required this.type, required this.content, required this.timestamp});

  factory FirestoreMessage.fromJson(Map<String, dynamic> json) => _$FirestoreMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FirestoreMessageToJson(this);

  static MessageType _enumFromJson(String value) {
    return MessageType.values.firstWhere((e) => e.toString().split('.').last == value);
  }

  static String _enumToJson(MessageType value) {
    return value.toString().split('.').last;
  }

  Message toMessage() {
    return Message(
        id: senderId ?? '', sendBy: senderId ?? '', message: content, createdAt: timestamp);
  }
}
