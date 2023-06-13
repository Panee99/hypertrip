import 'package:chatview/chatview.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse implements Serializable {
  String? firstName;
  String? lastName;
  String? birthDay;
  String? gender;
  String? address;
  String? id;
  String? phone;
  String? email;
  String? bankName;
  String? bankAccountNumber;
  @JsonKey(fromJson: _enumFromJson, toJson: _enumToJson)
  RoleStatus role;
  String? status;
  String? avatarUrl;

  ProfileResponse(
      {this.firstName,
      this.lastName,
      this.birthDay,
      this.gender,
      this.address,
      this.id,
      this.phone,
      this.email,
      this.bankName,
      this.bankAccountNumber,
      this.role = RoleStatus.TourGuide,
      this.status,
      this.avatarUrl});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

  static RoleStatus _enumFromJson(String value) {
    return RoleStatus.values
        .firstWhere((e) => e.toString().split('.').last == value);
  }

  static String _enumToJson(RoleStatus value) {
    return value.toString().split('.').last;
  }

  ChatUser toMember() {
    return ChatUser(
        id: id ?? '',
        name: firstName != null && firstName!.isNotEmpty
            ? '${firstName} ${lastName}'
            : lastName ?? '',
        profilePhoto: avatarUrl);
  }
}

enum RoleStatus {
  @JsonValue('Traveler')
  Traveler,
  @JsonValue('TourGuide')
  TourGuide,
}
