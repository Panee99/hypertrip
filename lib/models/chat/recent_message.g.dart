// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentMessage _$RecentMessageFromJson(Map<String, dynamic> json) =>
    RecentMessage(
      message: json['message'] as String? ?? '',
      sendAt: DateTime.parse(json['send_at'] as String),
      readBy: (json['readBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RecentMessageToJson(RecentMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'send_at': instance.sendAt.toIso8601String(),
      'readBy': instance.readBy,
    };
