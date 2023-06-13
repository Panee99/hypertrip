// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earth_quakes_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakesProperty _$EarthquakesPropertyFromJson(Map<String, dynamic> json) =>
    EarthquakesProperty(
      mag: (json['mag'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$EarthquakesPropertyToJson(
        EarthquakesProperty instance) =>
    <String, dynamic>{
      'mag': instance.mag,
    };
