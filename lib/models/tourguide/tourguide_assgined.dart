import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'tourguide_assgined.g.dart';

@JsonSerializable()
class TourGuideAssigned implements Serializable {
  String? id;
  String? code;
  int? maxOccupancy;
  String? title;
  String? departure;
  String? destination;
  String? startTime;
  String? endTime;
  double? adultPrice;
  double? childrenPrice;
  double? infantPrice;
  String? thumbnailUrl;
  String? description;
  String? type;
  String? status;

  TourGuideAssigned(
      {this.id,
      this.code,
      this.maxOccupancy,
      this.title,
      this.departure,
      this.destination,
      this.startTime,
      this.endTime,
      this.adultPrice,
      this.childrenPrice,
      this.infantPrice,
      this.thumbnailUrl,
      this.description,
      this.type,
      this.status});

  factory TourGuideAssigned.fromJson(Map<String, dynamic> json) =>
      _$TourGuideAssignedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TourGuideAssignedToJson(this);
}
