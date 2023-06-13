// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignGroupResponse _$AssignGroupResponseFromJson(Map<String, dynamic> json) =>
    AssignGroupResponse(
      id: json['id'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      groupName: json['groupName'] as String? ?? '',
      tourGuideId: json['tourGuideId'] as String? ?? '',
      maxOccupancy: json['maxOccupancy'] as int? ?? 0,
      tourVariantId: json['tourVariantId'] as String? ?? '',
      tourVariant: json['tourVariant'] == null
          ? null
          : TourVariant.fromJson(json['tourVariant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssignGroupResponseToJson(
        AssignGroupResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'groupName': instance.groupName,
      'tourGuideId': instance.tourGuideId,
      'maxOccupancy': instance.maxOccupancy,
      'tourVariantId': instance.tourVariantId,
      'tourVariant': instance.tourVariant,
    };
