// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecast _$WeatherForecastFromJson(Map<String, dynamic> json) =>
    WeatherForecast(
      forecastDay: (json['forecastday'] as List<dynamic>?)
              ?.map(
                  (e) => WeatherForecastDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WeatherForecastToJson(WeatherForecast instance) =>
    <String, dynamic>{
      'forecastday': instance.forecastDay,
    };
