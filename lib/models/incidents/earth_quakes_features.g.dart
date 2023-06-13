// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earth_quakes_features.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakesFeature _$EarthquakesFeatureFromJson(Map<String, dynamic> json) =>
    EarthquakesFeature(
      type: json['type'] as String? ?? '',
      properties: json['properties'] == null
          ? null
          : EarthquakesProperty.fromJson(
              json['properties'] as Map<String, dynamic>),
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$EarthquakesFeatureToJson(EarthquakesFeature instance) =>
    <String, dynamic>{
      'type': instance.type,
      'properties': instance.properties,
      'id': instance.id,
    };
