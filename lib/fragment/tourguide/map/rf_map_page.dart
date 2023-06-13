import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

class RFMapPage extends StatefulWidget {
  @override
  _RFMapPageState createState() => _RFMapPageState();
}

class _RFMapPageState extends State<RFMapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(16.463713, 107.590866), // Tọa độ ban đầu của bản đồ
    zoom: 10, // Độ phóng ban đầu
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Map'),
        automaticallyImplyLeading: false,
        backgroundColor: rf_primaryColor,
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers),
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        rotateGesturesEnabled: false,
        myLocationButtonEnabled: false,
        compassEnabled: false,
        mapToolbarEnabled: false,
        buildingsEnabled: false,
        initialCameraPosition: _kGooglePlex,
      ),
    );
  }
}
