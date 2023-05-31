part of 'repositories.dart';

class GoogleRepository {
  final apiKey = 'AIzaSyD826hryjncjuNGu1xDkDC6iAVv33O7nRI';
  Future<GoogleSearchPlaceResponse?> getSearchPlaceByCoordinate(
      double latitude, double longitude) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&key=${apiKey}');
    var response = await NetworkUtility.fetchUrl(url);
    if (response != null) {
      return GoogleSearchPlaceResponse.fromJson(jsonDecode(response.toString()));
    } else {
      return null;
    }
  }

  Future<String?> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var place = getSearchPlaceByCoordinate(position.latitude, position.longitude);
    String? compoundCode = await place.then((value) => value!.plusCode!.compoundCode.validate());

    if (compoundCode != null) {
      // Find the last comma index
      int lastCommaIndex = compoundCode.lastIndexOf(',');

      // Find the previous comma index
      int previousCommaIndex = compoundCode.lastIndexOf(',', lastCommaIndex - 1);

      // Get the substring between the two commas
      String substring = compoundCode.substring(previousCommaIndex + 1, lastCommaIndex).trim();

      return substring;
    }
  }

  // Future<GooglePlaceDetailResponse?> getPlaceDetail(String placeId) async {
  //   var url = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/place/details/json?place_id=${placeId}&key=${apiKey}');
  //   var response = await NetworkUtility.fetchUrl(url);
  //   if (response != null) {
  //     return GooglePlaceDetailResponse.fromJson(
  //         jsonDecode(response.toString()));
  //   } else {
  //     return null;
  //   }
  // }

  // Future<Widget> getPlacePhoto(String photoReference) async {
  //   var url = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/place/photo?&photoreference=${photoReference}&key=${apiKey}');

  //   var response = await http.get(url);

  //   final bytes = Uint8List.fromList(response.bodyBytes);
  //   final image = Image.memory(bytes);
  //   return image;
  //   // Use the image in your app
  // }

  Future<List<LatLng>> getDirection(LatLng startPoint, LatLng endPoint) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPoint.latitude},${startPoint.longitude}&destination=${endPoint.latitude},${endPoint.longitude}&key=$apiKey');
    var response = await http.get(url);
    var json = jsonDecode(response.body);

    List<LatLng> routeCoords = PolylinePoints()
        .decodePolyline(json['routes'][0]['overview_polyline']['points'])
        .cast<LatLng>();
    return routeCoords;
  }
}
