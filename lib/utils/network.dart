import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:room_finder_flutter/models/map/place_photo_response.dart';

import '../models/map/place_details_response.dart';
import 'QueryString.dart';

class NetworkUtility {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}

class GetPhotoByID {
  static Future<List<PlacesPhotoResponse>> getPlacePhoto(String id) async {
    var photoUrl = Uri.parse(
        '${queryString['placePhoto']!['uri']}${id}${queryString['placePhoto']!['photo']}');
    Map<String, String> header = Map<String, String>.from(
        queryString['placePhoto']!['header'] as Map<dynamic, dynamic>);
    var photoResponse =
        await NetworkUtility.fetchUrl(photoUrl, headers: header);
    // var photoResponse = await http.get(photoUrl, headers: header);
    List<PlacesPhotoResponse> parsePhotos(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<PlacesPhotoResponse>(
              (json) => PlacesPhotoResponse.fromJson(json))
          .toList();
    }

    return parsePhotos(photoResponse.toString());
  }
}

class GetPlaceDetail {
  Future<PlaceDetailsResponse> getPlaceDetails(String id) async {
    var url = Uri.parse('${queryString['placeDetails']}${id}');
    Map<String, String> header = Map<String, String>.from(
        queryString['placeDetails']!['header'] as Map<dynamic, dynamic>);
    var detailsResponse = await NetworkUtility.fetchUrl(url, headers: header);

    return PlaceDetailsResponse.fromJson(
        jsonDecode(detailsResponse.toString()));
  }
}
