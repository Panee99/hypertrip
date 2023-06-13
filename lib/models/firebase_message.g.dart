// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseMessage _$FirebaseMessageFromJson(Map<String, dynamic> json) =>
    FirebaseMessage(
      id: json['id'] as String? ?? "0",
      data: json['data'] as String? ?? '',
    );

Map<String, dynamic> _$FirebaseMessageToJson(FirebaseMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
    };
