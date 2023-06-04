// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreMessage _$FirestoreMessageFromJson(Map<String, dynamic> json) =>
    FirestoreMessage(
      docId: json['doc_id'] as String?,
      messageText: json['message_text'] as String,
      sentAt: DateTime.parse(json['sent_at'] as String),
      sentBy: json['sent_by'] as String,
    );

Map<String, dynamic> _$FirestoreMessageToJson(FirestoreMessage instance) =>
    <String, dynamic>{
      'doc_id': instance.docId,
      'message_text': instance.messageText,
      'sent_at': instance.sentAt.toIso8601String(),
      'sent_by': instance.sentBy,
    };
