import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour implements Serializable {
  String id;
  String title;
  String departure;
  String destination;
  String description;
  String? policy;
  String? thumbnailUrl;
  int maxOccupancy;
  @JsonKey(fromJson: _enumTypeFromJson, toJson: _enumTypeToJson)
  TourTypeStatus type;
  @JsonKey(fromJson: _enumFromJson, toJson: _enumToJson)
  TourStatus status;

  Tour(
      {this.id = '',
      this.title = '',
      this.departure = '',
      this.destination = '',
      this.description = '',
      this.policy,
      this.thumbnailUrl,
      this.maxOccupancy = 0,
      this.type = TourTypeStatus.Domestic,
      this.status = TourStatus.Closed});

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TourToJson(this);

  static TourStatus _enumFromJson(String value) {
    return TourStatus.values.firstWhere((e) => e.toString().split('.').last == value);
  }

  static String _enumToJson(TourStatus value) {
    return value.toString().split('.').last;
  }

  static TourTypeStatus _enumTypeFromJson(String value) {
    return TourTypeStatus.values.firstWhere((e) => e.toString().split('.').last == value);
  }

  static String _enumTypeToJson(TourTypeStatus value) {
    return value.toString().split('.').last;
  }
}

enum TourTypeStatus {
  @JsonValue('Domestic')
  Domestic,
  @JsonValue('International')
  International,
}

enum TourStatus {
  @JsonValue('New')
  New,
  @JsonValue('Active')
  Active,
  @JsonValue('Closed')
  Closed,
}
