// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      location: json['location'] == null
          ? null
          : WeatherLocation.fromJson(json['location'] as Map<String, dynamic>),
      current: json['current'] == null
          ? null
          : WeatherCurrent.fromJson(json['current'] as Map<String, dynamic>),
      alerts: json['alerts'] == null
          ? null
          : WeatherAlerts.fromJson(json['alerts'] as Map<String, dynamic>),
    )..foreCast = json['forecast'] == null
        ? null
        : WeatherForecast.fromJson(json['forecast'] as Map<String, dynamic>);

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
      'forecast': instance.foreCast,
      'alerts': instance.alerts,
    };
