import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/discovery/nearby_response.dart';
import 'package:room_finder_flutter/models/discovery/search_response.dart';

class MapDialog extends StatefulWidget {
  var lat, lng;
  NearbyPlacesResponse? places;
  NearbyResults? placeNearby;
  SearchResults? placeSearch;
  bool nearby;
  var category;
  MapDialog(
      {super.key,
      this.lat,
      this.lng,
      this.places,
      this.nearby = false,
      this.category,
      this.placeNearby,
      this.placeSearch});

  @override
  State<MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      widget.placeNearby != null
          ? _markers.add(
              Marker(
                markerId: MarkerId(widget.placeNearby!.fsqId.toString()),
                position: LatLng(widget.lat, widget.lng),
                infoWindow: InfoWindow(
                  title: widget.placeNearby!.name,
                  snippet: widget.placeNearby!.location!.address,
                ),
              ),
            )
          : _markers.add(
              Marker(
                markerId: MarkerId(widget.placeSearch!.fsqId.toString()),
                position: LatLng(widget.lat, widget.lng),
                infoWindow: InfoWindow(
                  title: widget.placeSearch!.name,
                  snippet: widget.placeSearch!.location!.address,
                ),
              ),
            );
    });
  }

  Future<Position> getPosition() async {
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
    return position;
  }

  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
            height: context.height() * 0.6,
            width: context.width() * 0.8,
            child: widget.places != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(widget.lat, widget.lng),
                          zoom: 17.0,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        markers: Set.from(widget.places!.results!.map((place) =>
                            Marker(
                                markerId: MarkerId(place.fsqId.toString()),
                                visible:
                                    widget.category == 'All'
                                        ? true
                                        : (place.categories!
                                                .where(
                                                    (item) => item.name!.contains(
                                                        widget.category))
                                                .toList()
                                                .isNotEmpty
                                            ? true
                                            : false),
                                position: LatLng(
                                    place.geocodes!.main!.latitude!.toDouble(),
                                    place.geocodes!.main!.longitude!
                                        .toDouble()),
                                infoWindow: InfoWindow(
                                    title: place.name,
                                    snippet: place.location!.address))))),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(widget.lat, widget.lng),
                          zoom: 17.0,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        markers: _markers),
                  )));
  }
}
