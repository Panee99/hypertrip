import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/incidents/earth_quakes_features.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'earth_quakes_response.g.dart';

@JsonSerializable()
class EarthquakesResponse implements Serializable {
  List<EarthquakesFeature> features;

  EarthquakesResponse({this.features = const []});

  factory EarthquakesResponse.fromJson(Map<String, dynamic> json) =>
      _$EarthquakesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EarthquakesResponseToJson(this);
}
