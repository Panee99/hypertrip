// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earth_quakes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakesResponse _$EarthquakesResponseFromJson(Map<String, dynamic> json) =>
    EarthquakesResponse(
      features: (json['features'] as List<dynamic>?)
              ?.map(
                  (e) => EarthquakesFeature.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$EarthquakesResponseToJson(
        EarthquakesResponse instance) =>
    <String, dynamic>{
      'features': instance.features,
    };
