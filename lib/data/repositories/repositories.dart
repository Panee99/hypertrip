import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/discovery/search_response.dart';
import 'package:room_finder_flutter/models/discovery/tip_response.dart';
import 'package:room_finder_flutter/models/goolge/google_search_place_response.dart';
import 'package:room_finder_flutter/models/ticket/ticket_list_response.dart';
import 'package:room_finder_flutter/models/tour/current_group_response.dart';
import 'package:room_finder_flutter/models/tour/joined_tour_response.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/models/tour/tour_flow_response.dart';
import 'package:room_finder_flutter/models/tour/tour_locations_response.dart';
import 'package:room_finder_flutter/models/tourguide/tourguide_assgined.dart';
import 'package:room_finder_flutter/models/user/avatar_response.dart';
import 'package:room_finder_flutter/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/discovery/nearby_response.dart';
import '../../models/discovery/place_details_response.dart';
import '../../models/discovery/place_photo_response.dart';
import '../../models/tour/tour_list_response.dart';
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

part 'app_repositories.dart';
part 'foursquare_repository.dart';
part 'google_repository.dart';
part 'tour_guide_repository.dart';

const String API_PROD_URL = "https://dotnet-travelers.fly.dev";
String get baseApiUrl => '$API_PROD_URL';
