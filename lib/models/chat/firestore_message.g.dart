// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreMessage _$FirestoreMessageFromJson(Map<String, dynamic> json) =>
    FirestoreMessage(
      senderId: json['SenderId'] as String?,
      type: FirestoreMessage._enumFromJson(json['Type'] as String),
      content: json['Content'] as String,
      timestamp: DateTime.parse(json['Timestamp'] as String),
    );

Map<String, dynamic> _$FirestoreMessageToJson(FirestoreMessage instance) =>
    <String, dynamic>{
      'SenderId': instance.senderId,
      'Type': FirestoreMessage._enumToJson(instance.type),
      'Content': instance.content,
      'Timestamp': instance.timestamp.toIso8601String(),
    };
