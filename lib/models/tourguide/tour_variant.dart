import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';
import 'package:room_finder_flutter/models/tourguide/tour.dart';

part 'tour_variant.g.dart';

@JsonSerializable()
class TourVariant implements Serializable {
  String id;
  String code;
  double adultPrice;
  double childrenPrice;
  double infantPrice;
  DateTime? startTime;
  DateTime? endTime;
  @JsonKey(fromJson: _enumFromJson, toJson: _enumToJson)
  TourVariantStatus status;
  String tourId;
  Tour? tour;

  TourVariant({
    this.id = '',
    this.code = '',
    this.adultPrice = 0.0,
    this.childrenPrice = 0.0,
    this.infantPrice = 0.0,
    this.startTime,
    this.endTime,
    this.status = TourVariantStatus.Ended,
    this.tourId = '',
    this.tour,
  });

  factory TourVariant.fromJson(Map<String, dynamic> json) => _$TourVariantFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TourVariantToJson(this);

  static TourVariantStatus _enumFromJson(String value) {
    return TourVariantStatus.values.firstWhere((e) => e.toString().split('.').last == value);
  }

  static String _enumToJson(TourVariantStatus value) {
    return value.toString().split('.').last;
  }
}

enum TourVariantStatus {
  @JsonValue('Accepting')
  Accepting,
  @JsonValue('Prepare')
  Prepare,
  @JsonValue('Ongoing')
  Ongoing,
  @JsonValue('Ended')
  Ended,
  @JsonValue('Canceled')
  Canceled,
}
