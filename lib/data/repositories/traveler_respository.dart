import 'dart:convert';

import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/tourguide/assign_group_response.dart';
import 'package:room_finder_flutter/utils/network.dart';

class TravelerRepository {
  Future<AssignGroupResponse> getAllCurrentGroups(String id) async {
    final response = await NetworkUtility.fetchUrl(
      Uri.parse('$baseApiUrl/travelers/${id}/current-group'),
      headers: mapHeader,
    );
    return response != null
        ? AssignGroupResponse.fromJson(jsonDecode(response))
        : AssignGroupResponse();
  }
}
