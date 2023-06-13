import 'package:json_annotation/json_annotation.dart';

part 'firebase_message.g.dart';

@JsonSerializable()
class FirebaseMessage {
  FirebaseMessage({
    this.id = "0",
    this.data = '',
  });

  String id;
  String data;

  FirebaseMessage copyWith({
    String? id,
    String? data,
  }) =>
      FirebaseMessage(
        id: id ?? this.id,
        data: data ?? this.data,
      );

  factory FirebaseMessage.fromJson(Map<String, dynamic> json) => _$FirebaseMessageFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseMessageToJson(this);
}
