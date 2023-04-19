import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/tour/tour_locations_response.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

class LocationTrackingComponent extends StatefulWidget {
  const LocationTrackingComponent({super.key});

  @override
  State<LocationTrackingComponent> createState() =>
      _LocationTrackingComponentState();
}

class _LocationTrackingComponentState extends State<LocationTrackingComponent> {
  late GoogleMapController mapController;
  List<LatLng> polylineCoordinates = [];
  late Future<Position> latLngPosition;
  late Future<List<TourLocationsResponse>?> tourLocationList;
  late AuthProvider authProvider;

  List<LatLng> _polylinePoints = [];
  Set<Marker> _markers = {};
  late LatLng? _previousPoint;

  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    super.initState();
    latLngPosition = _getCurrentLocation();
    getPolyPoints();
    tourLocationList = AppRepository().getTourLocations(
        'fd9e9810-4a0a-4cc0-afa5-08db3824da62', authProvider.token);
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    Position? position = await latLngPosition;
    setState(() {
      tourLocationList.then((value) => value!.forEach((element) {
            print(element.id);
            _markers.add(
              Marker(
                  markerId: MarkerId(element.id.toString()),
                  position: LatLng(element.latitude!.toDouble(),
                      element.longitude!.toDouble())),
            );
          }));
    });
  }

  Future<Position> _getCurrentLocation() async {
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
    // setState(() {
    //   _markers.add(Marker(
    //       markerId: MarkerId('my_location'),
    //       position: LatLng(position.latitude, position.latitude)));
    //   _polylinePoints.add(LatLng(position.latitude, position.latitude));
    // });
    // if (_previousPoint != null) {
    //   _polylines.add(Polyline(
    //     polylineId:
    //         PolylineId(_previousPoint.toString() + latLngPosition.toString()),
    //     points: [
    //       _previousPoint!,
    //       LatLng(position.latitude, position.longitude)
    //     ],
    //     color: Colors.blue,
    //     width: 3,
    //   ));
    // }
    // _previousPoint = LatLng(position.latitude, position.longitude);
    // _animateCameraToPosition(LatLng(position.latitude, position.longitude));
    _startLocationUpdates(position);
    _polylinePoints.forEach((element) {
      print(element.latitude);
    });
    return position;
    // mapController.animateCamera(
    //     CameraUpdate.newLatLngZoom(latLngPosition as LatLng, 1.0));
  }

  void _startLocationUpdates(Position currentLocation) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('my_location'),
          position:
              LatLng(currentLocation.latitude, currentLocation.latitude)));
      _polylinePoints
          .add(LatLng(currentLocation.latitude, currentLocation.latitude));
      tourLocationList.then((value) => value!.forEach((position) {
            LatLng latLng = LatLng(
                position.latitude!.toDouble(), position.longitude!.toDouble());
            _markers.add(Marker(
              markerId: MarkerId('tour_location: ' + position.id.toString()),
              position: latLng,
            ));
            _polylinePoints.add(latLng);
          }));
    });
    // _updatePolyline();
    ;
  }

  void _animateCameraToPosition(LatLng latLng) async {
    await mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: latLng,
        zoom: 10,
      ),
    ));
  }

  void _updatePolyline() async {
    if (_polylinePoints.length > 1) {
      await mapController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: _polylinePoints.first,
          northeast: _polylinePoints.last,
        ),
        15,
      ));
    }
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    Position? position = await latLngPosition;
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAPZiYIlR-ztOa6maus6urUhs1Z-6spyj4',
      PointLatLng(position.latitude, position.longitude),
      PointLatLng(10.7948267, 106.7223256),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
        future: latLngPosition,
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: context.height() * 0.5,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            final latlng = snapshot.data!;
            return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                    target: LatLng(latlng.latitude, latlng.longitude),
                    zoom: 12.0),
                polylines: {
                  Polyline(
                      polylineId: PolylineId('route'),
                      points: _polylinePoints,
                      color: rf_primaryColor,
                      width: 6)
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                markers: _markers
                // {
                //   Marker(
                //       markerId: MarkerId('departure'),
                //       position: LatLng(latlng.latitude, latlng.longitude)),
                //   Marker(
                //       markerId: MarkerId('destination'),
                //       position: LatLng(10.7948267, 106.7223256)),
                // },
                );
          }
        });
  }
}
