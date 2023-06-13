// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_alerts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherAlerts _$WeatherAlertsFromJson(Map<String, dynamic> json) =>
    WeatherAlerts(
      alert: (json['alert'] as List<dynamic>?)
              ?.map((e) => WeatherAlert.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WeatherAlertsToJson(WeatherAlerts instance) =>
    <String, dynamic>{
      'alert': instance.alert,
    };
