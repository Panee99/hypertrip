import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'firestore_message.g.dart';

@JsonSerializable()
class FirestoreMessage implements Serializable {
  @JsonKey(name: 'doc_id')
  String? docId;
  @JsonKey(name: 'message_text')
  String messageText;
  @JsonKey(name: 'sent_at')
  DateTime sentAt;

  /// UID người gửi
  @JsonKey(name: 'sent_by')
  String sentBy;

  FirestoreMessage(
      {this.docId, required this.messageText, required this.sentAt, required this.sentBy});

  factory FirestoreMessage.fromJson(Map<String, dynamic> json) => _$FirestoreMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FirestoreMessageToJson(this);
}
