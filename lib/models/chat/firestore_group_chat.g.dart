// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_group_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreGroupChat _$FirestoreGroupChatFromJson(Map<String, dynamic> json) =>
    FirestoreGroupChat(
      createdBy: json['created_by'] as String? ?? '',
      id: json['id'] as String? ?? '',
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      titleGroup: json['title_group'] as String? ?? '',
      type: json['type'] as int? ?? 1,
      createAt: DateTime.parse(json['create_at'] as String),
      modifiedAt: DateTime.parse(json['modified_at'] as String),
    );

Map<String, dynamic> _$FirestoreGroupChatToJson(FirestoreGroupChat instance) =>
    <String, dynamic>{
      'created_by': instance.createdBy,
      'id': instance.id,
      'members': instance.members,
      'create_at': instance.createAt.toIso8601String(),
      'modified_at': instance.modifiedAt.toIso8601String(),
      'title_group': instance.titleGroup,
      'type': instance.type,
    };
