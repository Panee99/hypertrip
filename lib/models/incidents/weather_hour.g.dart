// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_hour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherHour _$WeatherHourFromJson(Map<String, dynamic> json) => WeatherHour(
      timeEpoch: json['time_epoch'] as int? ?? 0,
      time: json['time'] as String? ?? '',
      tempC: (json['temp_c'] as num?)?.toDouble() ?? 0.0,
      tempF: (json['temp_f'] as num?)?.toDouble() ?? 0.0,
      isDay: json['is_day'] as int? ?? 0,
      condition: json['condition'] == null
          ? null
          : WeatherCondition.fromJson(
              json['condition'] as Map<String, dynamic>),
      windMph: (json['wind_mph'] as num?)?.toDouble() ?? 0.0,
      windKph: (json['wind_kph'] as num?)?.toDouble() ?? 0.0,
      windDegree: json['wind_degree'] as int? ?? 0,
      windDir: json['wind_dir'] as String? ?? '',
      pressureMb: (json['pressure_mb'] as num?)?.toDouble() ?? 0.0,
      pressureIn: (json['pressure_in'] as num?)?.toDouble() ?? 0.0,
      precipMm: (json['precip_mm'] as num?)?.toDouble() ?? 0.0,
      precipIn: (json['precip_in'] as num?)?.toDouble() ?? 0.0,
      humidity: json['humidity'] as int? ?? 0,
      cloud: json['cloud'] as int? ?? 0,
      feelslikeC: (json['feelslike_c'] as num?)?.toDouble() ?? 0.0,
      feelslikeF: (json['feelslike_f'] as num?)?.toDouble() ?? 0.0,
      windchillC: (json['windchill_c'] as num?)?.toDouble() ?? 0.0,
      windchillF: (json['windchill_f'] as num?)?.toDouble() ?? 0.0,
      heatindexC: (json['heatindex_c'] as num?)?.toDouble() ?? 0.0,
      heatindexF: (json['heatindex_f'] as num?)?.toDouble() ?? 0.0,
      dewpointC: (json['dewpoint_c'] as num?)?.toDouble() ?? 0.0,
      dewpointF: (json['dewpoint_f'] as num?)?.toDouble() ?? 0.0,
      willItRain: json['will_it_rain'] as int? ?? 0,
      chanceOfRain: json['chance_of_rain'] as int? ?? 0,
      willItSnow: json['will_it_snow'] as int? ?? 0,
      chanceOfSnow: json['chance_of_snow'] as int? ?? 0,
      visKm: (json['vis_km'] as num?)?.toDouble() ?? 0.0,
      visMiles: (json['vis_miles'] as num?)?.toDouble() ?? 0.0,
      gustMph: (json['gust_mph'] as num?)?.toDouble() ?? 0.0,
      gustKph: (json['gust_kph'] as num?)?.toDouble() ?? 0.0,
      uv: (json['uv'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$WeatherHourToJson(WeatherHour instance) =>
    <String, dynamic>{
      'time_epoch': instance.timeEpoch,
      'time': instance.time,
      'temp_c': instance.tempC,
      'temp_f': instance.tempF,
      'is_day': instance.isDay,
      'condition': instance.condition,
      'wind_mph': instance.windMph,
      'wind_kph': instance.windKph,
      'wind_degree': instance.windDegree,
      'wind_dir': instance.windDir,
      'pressure_mb': instance.pressureMb,
      'pressure_in': instance.pressureIn,
      'precip_mm': instance.precipMm,
      'precip_in': instance.precipIn,
      'humidity': instance.humidity,
      'cloud': instance.cloud,
      'feelslike_c': instance.feelslikeC,
      'feelslike_f': instance.feelslikeF,
      'windchill_c': instance.windchillC,
      'windchill_f': instance.windchillF,
      'heatindex_c': instance.heatindexC,
      'heatindex_f': instance.heatindexF,
      'dewpoint_c': instance.dewpointC,
      'dewpoint_f': instance.dewpointF,
      'will_it_rain': instance.willItRain,
      'chance_of_rain': instance.chanceOfRain,
      'will_it_snow': instance.willItSnow,
      'chance_of_snow': instance.chanceOfSnow,
      'vis_km': instance.visKm,
      'vis_miles': instance.visMiles,
      'gust_mph': instance.gustMph,
      'gust_kph': instance.gustKph,
      'uv': instance.uv,
    };
