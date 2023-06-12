// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreUser _$FirestoreUserFromJson(Map<String, dynamic> json) =>
    FirestoreUser(
      docId: json['doc_id'] as String?,
      uid: json['uid'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
      photoURL: json['photo_url'] as String? ?? '',
      email: json['email'] as String? ?? '',
      groups: (json['groups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FirestoreUserToJson(FirestoreUser instance) =>
    <String, dynamic>{
      'doc_id': instance.docId,
      'uid': instance.uid,
      'display_name': instance.displayName,
      'photo_url': instance.photoURL,
      'email': instance.email,
      'groups': instance.groups,
    };
