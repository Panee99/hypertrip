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
}
