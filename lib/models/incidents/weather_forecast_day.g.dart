// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecastDay _$WeatherForecastDayFromJson(Map<String, dynamic> json) =>
    WeatherForecastDay(
      hour: (json['hour'] as List<dynamic>?)
              ?.map((e) => WeatherHour.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WeatherForecastDayToJson(WeatherForecastDay instance) =>
    <String, dynamic>{
      'hour': instance.hour,
    };
