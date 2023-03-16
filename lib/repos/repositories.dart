import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';

import '../models/map/nearby_response.dart';

class PlaceRepository {
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
    var url = Uri.parse('https://api.foursquare.com/v3/places/nearby?ll=' +
        position.latitude.toString() +
        '%2C' +
        position.longitude.toString());
    var header = {
      'Accept': 'application/json',
      'Authorization': 'fsq37qFTKrGLWiBZDd6Eexr+8xiKOhen6VB/vTmq42RlKSs=',
      'Host': 'api.foursquare.com'
    };
    var response = await http.get(url, headers: header);
    return NearbyPlacesResponse.fromJson(jsonDecode(response.body));
  }
}
