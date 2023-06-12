import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'earth_quakes_property.g.dart';

@JsonSerializable()
class EarthquakesProperty implements Serializable {
  double mag;

  EarthquakesProperty({this.mag = 0.0});

  factory EarthquakesProperty.fromJson(Map<String, dynamic> json) =>
      _$EarthquakesPropertyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EarthquakesPropertyToJson(this);
}
