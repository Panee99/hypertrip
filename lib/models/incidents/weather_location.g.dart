// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherLocation _$WeatherLocationFromJson(Map<String, dynamic> json) =>
    WeatherLocation(
      name: json['name'] as String? ?? '',
      region: json['region'] as String? ?? '',
      country: json['country'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lgn: (json['lon'] as num?)?.toDouble() ?? 0.0,
      tzId: json['tz_id'] as String? ?? '',
      localtimeEpoch: json['localtime_epoch'] as int? ?? 0,
      localtime: json['localtime'] as String? ?? '',
    );

Map<String, dynamic> _$WeatherLocationToJson(WeatherLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'region': instance.region,
      'country': instance.country,
      'lat': instance.lat,
      'lon': instance.lgn,
      'tz_id': instance.tzId,
      'localtime_epoch': instance.localtimeEpoch,
      'localtime': instance.localtime,
    };
