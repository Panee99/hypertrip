part of 'repositories.dart';

final mapHeader = {'accept': 'application/json'};

class AppRepository {
  Future<String> getToken(String username, String password) async {
    final token = jsonDecode((await NetworkUtility.post(
      Uri.parse('$baseApiUrl/auth'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json-patch+json',
      },
      body: jsonEncode({"username": username, "password": password}),
    ))!)['token'];

    mapHeader.addAll({'Authorization': '${token.toString()}'});
    return token;
  }

  Future<ProfileResponse>? getUserProfile(String token) async {
    final authResponse = await NetworkUtility.fetchUrl(
        Uri.parse('$baseApiUrl/users/self/profile'),
        headers: {
          'Authorization': '${token.toString()}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        });
    return ProfileResponse.fromJson(jsonDecode(authResponse!));
  }

  Future<List<TicketListResponse>> getTicketList(
      String userId, String token) async {
    final response =
        await NetworkUtility.post(Uri.parse('$baseApiUrl/tickets/filter'),
            headers: {
              'Authorization': '${token}',
              'Content-Type': 'application/json-patch+json',
            },
            body: jsonEncode({'travelerId': '${userId}'}));
    List<TicketListResponse> parseTicket(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<TicketListResponse>((json) => TicketListResponse.fromJson(json))
          .toList();
    }

    parseTicket(response.toString()).forEach((ticket) {
      print(ticket.tourId);
    });
    return parseTicket(response.toString());
  }

  Future<TourDetailResponse> getTourDetail(String tourId) async {
    final response = await NetworkUtility.fetchUrl(
      Uri.parse('$baseApiUrl/tours/${tourId}/details'),
      headers: mapHeader,
    );
    return TourDetailResponse.fromJson(jsonDecode(response!));
  }

  Future<AvatarResponse?> getUserAvatar(String token) async {
    final response = await NetworkUtility.fetchUrl(
      Uri.parse('$baseApiUrl/accounts/avatar'),
      headers: mapHeader,
    );
    if (response != null) {
      return AvatarResponse.fromJson(jsonDecode(response));
    }
    return null;
  }

  Future<List<TourLocationsResponse>?> getTourLocations(
      String id, String token) async {
    final response = await NetworkUtility.fetchUrl(
      Uri.parse('$baseApiUrl/tours/${id}/locations'),
      headers: mapHeader,
    );
    if (response != null) {
      List<TourLocationsResponse> parseLocation(String responseBody) {
        final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
        return parsed
            .map<TourLocationsResponse>(
                (json) => TourLocationsResponse.fromJson(json))
            .toList();
      }

      return parseLocation(response.toString());
    }
    return null;
  }

  Future<TourListResponse> getTourList() async {
    final response =
        await NetworkUtility.post(Uri.parse('$baseApiUrl/tours/filter'),
            headers: {
              // 'Authorization': '${token}',
              'accept': 'application/json',
              'Content-Type': 'application/json-patch+json',
            },
            body: jsonEncode({'page': '1', 'size': '10'}));
    return TourListResponse.fromJson(jsonDecode(response!));
  }

  Future<List<JoinedTourResponse>?> getJoinedTour(
      String travelerId, String token) async {
    final response = await NetworkUtility.fetchUrl(
      Uri.parse('$baseApiUrl/travelers/${travelerId}/joined-tours'),
      headers: mapHeader,
    );
    if (response != null) {
      List<JoinedTourResponse> parseTour(String body) {
        final parsed = json.decode(body).cast<Map<String, dynamic>>();
        return parsed
            .map<JoinedTourResponse>(
                (json) => JoinedTourResponse.fromJson(json))
            .toList();
      }

      return parseTour(response.toString());
    }
    return null;
  }

  // TODO: Waiting BE update data response
  Future<dynamic> getAttendances(String travelerId) async {
    final response = await NetworkUtility.fetchUrl(
      Uri.parse('$baseApiUrl//attendance-events/$travelerId/attendances'),
      headers: mapHeader,
    );
    return response;
  }

  Future<dynamic> getProfileUser(String uID) async {
    final response = await NetworkUtility.fetchUrl(
      Uri.parse('$baseApiUrl/users/$uID'),
      headers: mapHeader,
    );
    return response;
  }

  Future<List<TourFlowResponse>> getTourFlow(String tourId) async {
    final response = await NetworkUtility.fetchUrl(
        Uri.parse('$baseApiUrl/tours/${tourId}/schedules'),
        headers: mapHeader);
    List<TourFlowResponse> parsedTourFlow(String body) {
      final parsed = json.decode(body).cast<Map<String, dynamic>>();
      return parsed
          .map<TourFlowResponse>((json) => TourFlowResponse.fromJson(json))
          .toList();
    }

    return parsedTourFlow(response.toString());
  }

  Future<CurrentGroupResponse> getCurrentGroup(
      String travelerId, String token) async {
    final response = await NetworkUtility.fetchUrl(
        Uri.parse('$baseApiUrl/travelers/${travelerId}/current-group'),
        headers: {
          'Authorization': '${token.toString()}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        });
    return CurrentGroupResponse.fromJson(jsonDecode(response!));
  }

  Future<AttachmentFile> attachmentsFile(File file) async {
    mapHeader.addAll({'Content-Type': 'multipart/form-data'});

    final response = await NetworkUtility.uploadFile(
        Uri.parse('$baseApiUrl/attachments'),
        headers: mapHeader,
        path: file.path);
    return response == null
        ? AttachmentFile()
        : AttachmentFile.fromJson(jsonDecode(response));
  }

  /// Add token FCM
  Future<dynamic> addTokenFCMApi(String tokenFCM, String uID) async {
    final response =
        await NetworkUtility.post(Uri.parse('$baseApiUrl/fcm-tokens'),
            headers: {
              'accept': 'application/json',
              'Content-Type': 'application/json-patch+json',
            },
            body: jsonEncode({'token': tokenFCM, 'userId': uID}));
    return response;
  }

  /// Delete token FCM
  Future<dynamic> deleteTokenFCMApi(String uID) async {
    final response =
        await NetworkUtility.post(Uri.parse('$baseApiUrl/fcm-tokens/${uID}'));
    return response;
  }
}
