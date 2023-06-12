// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      birthDay: json['birthDay'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      id: json['id'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      bankName: json['bankName'] as String?,
      bankAccountNumber: json['bankAccountNumber'] as String?,
      role: json['role'] == null
          ? RoleStatus.TourGuide
          : ProfileResponse._enumFromJson(json['role'] as String),
      status: json['status'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDay': instance.birthDay,
      'gender': instance.gender,
      'address': instance.address,
      'id': instance.id,
      'phone': instance.phone,
      'email': instance.email,
      'bankName': instance.bankName,
      'bankAccountNumber': instance.bankAccountNumber,
      'role': ProfileResponse._enumToJson(instance.role),
      'status': instance.status,
      'avatarUrl': instance.avatarUrl,
    };
