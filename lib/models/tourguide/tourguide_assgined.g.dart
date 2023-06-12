// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tourguide_assgined.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourGuideAssigned _$TourGuideAssignedFromJson(Map<String, dynamic> json) =>
    TourGuideAssigned(
      id: json['id'] as String?,
      code: json['code'] as String?,
      maxOccupancy: json['maxOccupancy'] as int?,
      title: json['title'] as String?,
      departure: json['departure'] as String?,
      destination: json['destination'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      adultPrice: (json['adultPrice'] as num?)?.toDouble(),
      childrenPrice: (json['childrenPrice'] as num?)?.toDouble(),
      infantPrice: (json['infantPrice'] as num?)?.toDouble(),
      thumbnailUrl: json['thumbnailUrl'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TourGuideAssignedToJson(TourGuideAssigned instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'maxOccupancy': instance.maxOccupancy,
      'title': instance.title,
      'departure': instance.departure,
      'destination': instance.destination,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'adultPrice': instance.adultPrice,
      'childrenPrice': instance.childrenPrice,
      'infantPrice': instance.infantPrice,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'type': instance.type,
      'status': instance.status,
    };
