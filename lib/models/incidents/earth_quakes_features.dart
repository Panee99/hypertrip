import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/incidents/earth_quakes_property.dart';

part 'earth_quakes_features.g.dart';

@JsonSerializable()
class EarthquakesFeature {
  String type;
  EarthquakesProperty? properties;
  String id;

  EarthquakesFeature({this.type = '', this.properties, this.id = ''});

  factory EarthquakesFeature.fromJson(Map<String, dynamic> json) =>
      _$EarthquakesFeatureFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EarthquakesFeatureToJson(this);
}
