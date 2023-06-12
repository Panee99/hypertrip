// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tour _$TourFromJson(Map<String, dynamic> json) => Tour(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      departure: json['departure'] as String? ?? '',
      destination: json['destination'] as String? ?? '',
      description: json['description'] as String? ?? '',
      policy: json['policy'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      maxOccupancy: json['maxOccupancy'] as int? ?? 0,
      type: json['type'] == null
          ? TourTypeStatus.Domestic
          : Tour._enumTypeFromJson(json['type'] as String),
      status: json['status'] == null
          ? TourStatus.Closed
          : Tour._enumFromJson(json['status'] as String),
    );

Map<String, dynamic> _$TourToJson(Tour instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'departure': instance.departure,
      'destination': instance.destination,
      'description': instance.description,
      'policy': instance.policy,
      'thumbnailUrl': instance.thumbnailUrl,
      'maxOccupancy': instance.maxOccupancy,
      'type': Tour._enumTypeToJson(instance.type),
      'status': Tour._enumToJson(instance.status),
    };
