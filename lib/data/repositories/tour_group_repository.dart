import 'dart:convert';

import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/user/profile_response.dart';
import 'package:room_finder_flutter/utils/network.dart';

class TourGroupRepository {
  Future<List<ProfileResponse>> getMembersTourGroup(String tourGuideId) async {
    final response = await NetworkUtility.fetchUrl(
      Uri.parse('$baseApiUrl/tour-groups/${tourGuideId}/members'),
      headers: mapHeader,
    );
    return response != null
        ? (jsonDecode(response) as List<dynamic>)
            .map((profile) => ProfileResponse.fromJson(profile))
            .toList()
        : [];
  }

  Future<List<String>> getAllTokenFCMDeviceGroup(List<String> userIds) async {
    final body = json.encode(userIds);
    final response = await NetworkUtility.post(Uri.parse('$baseApiUrl/fcm-tokens/find-by-users'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json-patch+json',
        },
        body: body);
    return response != null
        ? (jsonDecode(response) as List<dynamic>).map((res) => res['token'] as String).toList()
        : [];
  }
}
