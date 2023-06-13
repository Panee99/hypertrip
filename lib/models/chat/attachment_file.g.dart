// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentFile _$AttachmentFileFromJson(Map<String, dynamic> json) =>
    AttachmentFile(
      id: json['id'] as String? ?? '',
      contentType: json['contentType'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$AttachmentFileToJson(AttachmentFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contentType': instance.contentType,
      'url': instance.url,
    };
