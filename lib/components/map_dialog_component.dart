import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

class MapDialog extends StatefulWidget {
  double lat, lng;
  LatLng currentLatLng;
  MapDialog(
      {super.key,
      required this.lat,
      required this.lng,
      required this.currentLatLng});

  @override
  State<MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {
  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  bool isCurrentLoction() {
    return (widget.lat == widget.currentLatLng.latitude &&
            widget.lng == widget.currentLatLng.longitude)
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: context.height() * 0.6,
        width: context.width() * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  isCurrentLoction()
                      ? widget.currentLatLng.latitude
                      : widget.lat,
                  isCurrentLoction()
                      ? widget.currentLatLng.longitude
                      : widget.lng),
              zoom: 10.0,
            ),
            myLocationEnabled: isCurrentLoction() ? true : false,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
          ),
        ),
      ),
    );
  }
}
