import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/discovery/search_response.dart';
import 'package:room_finder_flutter/models/discovery/tip_response.dart';
import 'package:room_finder_flutter/models/ticket/ticket_list_response.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/models/tour/tour_locations_response.dart';
import 'package:room_finder_flutter/models/user/avatar_response.dart';

import '../../models/discovery/nearby_response.dart';
import '../../models/discovery/place_details_response.dart';
import '../../models/discovery/place_photo_response.dart';
import '../../models/user/sign_in_model.dart';
import '../../utils/QueryString.dart';
import '../../utils/network.dart';

// class PlaceRepository {
//   Future<NearbyPlacesResponse> getNearbyPlaces() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         // return null;
//       }
//     }
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     var url = Uri.parse('${queryString['nearbyPlace']!['uri']}' +
//         position.latitude.toString() +
//         '${queryString['nearbyPlace']![',']}' +
//         position.longitude.toString());
//     Map<String, String> header = Map<String, String>.from(
//         queryString['nearbyPlace']!['header'] as Map<dynamic, dynamic>);
//     var response = await http.get(url, headers: header);
//     print(position.latitude.toString() + ', ' + position.longitude.toString());
//     // print(NearbyPlacesResponse.fromJson(jsonDecode(response.body))
//     //     .results!
//     //     .length);
//     return NearbyPlacesResponse.fromJson(jsonDecode(response.body));
//   }
// }

class FoursquareRepository {
  Future<NearbyPlacesResponse> getNearbyPlaces() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var url = Uri.parse('${queryString['nearbyPlace']!['uri']}' +
        position.latitude.toString() +
        '${queryString['nearbyPlace']![',']}' +
        position.longitude.toString() +
        '${queryString['nearbyPlace']!['radius']}${queryString['nearbyPlace']!['sort']}${queryString['nearbyPlace']!['limit']}');
    Map<String, String> header = Map<String, String>.from(
        queryString['nearbyPlace']!['header'] as Map<dynamic, dynamic>);
    var response = await http.get(url, headers: header);
    return NearbyPlacesResponse.fromJson(jsonDecode(response.body));
  }

  Future<List<PlacesPhotoResponse>> getPlacePhoto(String id) async {
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

  Future<PlaceDetailsResponse> getPlaceDetails(String id) async {
    var url = Uri.parse('${queryString['placeDetails']}${id}');
    Map<String, String> header = Map<String, String>.from(
        queryString['placeDetails']!['header'] as Map<dynamic, dynamic>);
    var detailsResponse = await NetworkUtility.fetchUrl(url, headers: header);

    return PlaceDetailsResponse.fromJson(
        jsonDecode(detailsResponse.toString()));
  }

  Future<SearchPlaceResponse> searchPlace(
    String query,
  ) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var url = Uri.parse('${queryString['searchPlace']!['uri']}${query}' +
        '${queryString['searchPlace']!['ll']}' +
        position.latitude.toString() +
        '${queryString['searchPlace']![',']}' +
        position.longitude.toString() +
        '${queryString['searchPlace']!['radius']}${queryString['nearbyPlace']!['sort']}${queryString['nearbyPlace']!['limit']}');
    Map<String, String> header = Map<String, String>.from(
        queryString['searchPlace']!['header'] as Map<dynamic, dynamic>);
    var response = await NetworkUtility.fetchUrl(url, headers: header);
    return SearchPlaceResponse.fromJson(jsonDecode(response.toString()));
  }

  Future<List<TipResponse>> tip(String placeId) async {
    var url = Uri.parse(
        '${queryString['tip']!['uri']}${placeId}${queryString['tip']!['tip']}${queryString['tip']!['sort']}');
    Map<String, String> header = Map<String, String>.from(
        queryString['tip']!['header'] as Map<dynamic, dynamic>);
    var response = await NetworkUtility.fetchUrl(url, headers: header);
    List<TipResponse> parseTips(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<TipResponse>((json) => TipResponse.fromJson(json))
          .toList();
    }

    print(parseTips(response.toString()).first.text);
    return parseTips(response.toString());
  }
}

class AppRepository {
  Future<String> getToken(String email, String password) async {
    final token = jsonDecode((await NetworkUtility.post(
      Uri.parse('https://dotnet-travelers.fly.dev/auth'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json-patch+json',
      },
      body: jsonEncode({"username": email, "password": password}),
    ))!)['token'];
    return token;
  }

  Future<ProfileResponse>? getUserProfile(String token) async {
    var authResponse = await NetworkUtility.fetchUrl(
        Uri.parse('https://dotnet-travelers.fly.dev/accounts/self/profile'),
        headers: {
          'Authorization': '${token.toString()}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        });
    print(authResponse);
    return ProfileResponse.fromJson(jsonDecode(authResponse!));
  }

  Future<List<TicketListResponse>> getTicketList(
      String userId, String token) async {
    var response = await NetworkUtility.post(
        Uri.parse('https://dotnet-travelers.fly.dev/tickets/filter'),
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

  Future<TourDetailResponse> getTourDetail(String tourId, String token) async {
    var response = await NetworkUtility.fetchUrl(
        Uri.parse('https://dotnet-travelers.fly.dev/tours/${tourId}'),
        headers: {
          'Authorization': '${token.toString()}',
          'accept': 'application/json',
        });
    print(TourDetailResponse.fromJson(jsonDecode(response!)));
    return TourDetailResponse.fromJson(jsonDecode(response!));
  }

  Future<AvatarResponse?> getUserAvatar(String token) async {
    var response = await NetworkUtility.fetchUrl(
        Uri.parse('https://dotnet-travelers.fly.dev/accounts/avatar'),
        headers: {
          'Authorization': '${token.toString()}',
          'accept': 'application/json',
        });
    if (response != null) {
      return AvatarResponse.fromJson(jsonDecode(response));
    }
    return null;
  }

  Future<List<TourLocationsResponse>?> getTourLocations(
      String id, String token) async {
    var response = await NetworkUtility.fetchUrl(
        Uri.parse('https://dotnet-travelers.fly.dev/tours/${id}/locations'),
        headers: {
          'Authorization': '${token.toString()}',
          'accept': 'application/json',
        });
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

  Future<List<TourDetailResponse>> getTourList(String page, String size) async {
    var response = await NetworkUtility.post(
        Uri.parse('https://dotnet-travelers.fly.dev/tours/filter'),
        headers: {
          // 'Authorization': '${token}',
          'accept': 'application/json',
          'Content-Type': 'application/json-patch+json',
        },
        body: jsonEncode({"page": page, "size": size}));
    List<TourDetailResponse> parseTour(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<TourDetailResponse>((json) => TourDetailResponse.fromJson(json))
          .toList();
    }

    parseTour(response.toString()).forEach((tour) {
      print(tour.id);
    });
    return parseTour(response.toString());
  }

  Future<List<TourDetailResponse>> getTourDetails(String id) async {
    var response = await NetworkUtility.post(
      Uri.parse('https://dotnet-travelers.fly.dev/tours/${id}/details'),
      headers: {
        // 'Authorization': '${token}',
        'accept': 'application/json',
      },
    );
    List<TourDetailResponse> parseTour(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<TourDetailResponse>((json) => TourDetailResponse.fromJson(json))
          .toList();
    }

    parseTour(response.toString()).forEach((tour) {
      print(tour.id);
    });
    return parseTour(response.toString());
  }
}
