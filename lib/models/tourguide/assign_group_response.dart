import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/tour_variant.dart';

part 'assign_group_response.g.dart';

@JsonSerializable()
class AssignGroupResponse {
  String id;
  DateTime? createdAt;
  String groupName;
  String tourGuideId;
  int maxOccupancy;
  String tourVariantId;
  TourVariant? tourVariant;

  AssignGroupResponse({
    this.id = '',
    this.createdAt,
    this.groupName = '',
    this.tourGuideId = '',
    this.maxOccupancy = 0,
    this.tourVariantId = '',
    this.tourVariant,
  });

  factory AssignGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$AssignGroupResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssignGroupResponseToJson(this);
}
