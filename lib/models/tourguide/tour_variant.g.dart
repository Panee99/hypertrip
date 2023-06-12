// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourVariant _$TourVariantFromJson(Map<String, dynamic> json) => TourVariant(
      id: json['id'] as String? ?? '',
      code: json['code'] as String? ?? '',
      adultPrice: (json['adultPrice'] as num?)?.toDouble() ?? 0.0,
      childrenPrice: (json['childrenPrice'] as num?)?.toDouble() ?? 0.0,
      infantPrice: (json['infantPrice'] as num?)?.toDouble() ?? 0.0,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      status: json['status'] == null
          ? TourVariantStatus.Ended
          : TourVariant._enumFromJson(json['status'] as String),
      tourId: json['tourId'] as String? ?? '',
      tour: json['tour'] == null
          ? null
          : Tour.fromJson(json['tour'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TourVariantToJson(TourVariant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'adultPrice': instance.adultPrice,
      'childrenPrice': instance.childrenPrice,
      'infantPrice': instance.infantPrice,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'status': TourVariant._enumToJson(instance.status),
      'tourId': instance.tourId,
      'tour': instance.tour,
    };
