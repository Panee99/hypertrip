import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/components/location_list_tile.dart';
import 'package:room_finder_flutter/components/map_dialog_component.dart';
import 'package:room_finder_flutter/components/nearby_places_component.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:room_finder_flutter/utils/network.dart';

import '../utils/RFColors.dart';
import '../utils/RFWidget.dart';

class MapFragment extends StatefulWidget {
  const MapFragment({super.key});

  @override
  State<MapFragment> createState() => _MapFragmentState();
}

class _MapFragmentState extends State<MapFragment> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  TextEditingController place = TextEditingController();

  FocusNode placeFocusNode = FocusNode();

  String dropdownValue = 'All';

  late LatLng latLngPosition = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latLngPosition = LatLng(position.latitude, position.longitude);
    });

    // Move camera to the current location
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(latLngPosition, 2.0));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dialog mapDialog = Dialog(
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12.0)), //this right here
    //   child: Container(
    //     height: screenHeight * 0.6,
    //     width: screenWidth * 0.8,
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(10),
    //       child: GoogleMap(
    //         onMapCreated: _onMapCreated,
    //         initialCameraPosition: CameraPosition(
    //           target: latLngPosition,
    //           zoom: 10.0,
    //         ),
    //         myLocationEnabled: true,
    //         myLocationButtonEnabled: true,
    //         zoomControlsEnabled: true,
    //         zoomGesturesEnabled: true,
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: RFCommonAppComponent(
        scroll: true,
        // title: RFAppName,
        mainWidgetHeight: screenHeight * 0.2,
        subWidgetHeight: screenHeight * 0.1,
        cardWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text('Tìm Kiếm', style: boldTextStyle(size: 18)),
            // 16.height,
            AppTextField(
              controller: place,
              focus: placeFocusNode,
              textFieldType: TextFieldType.NAME,
              decoration: rfInputDecoration(
                lableText: "Bạn muốn tìm...",
                showLableText: true,
                showPreFixIcon: true,
                prefixIcon:
                    Icon(Icons.search, color: rf_primaryColor, size: 16),
              ),
            ),
            16.height,
            AppButton(
              color: rf_primaryColor,
              child: Text('Tìm', style: boldTextStyle(color: white)),
              width: context.width(),
              elevation: 0,
              onTap: () {
                // RFSearchDetailScreen().launch(context);
              },
            ),
          ],
        ),
        subWidget: Column(
          children: [
            Container(
              width: context.width(),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(child: Text('Nearby', style: boldTextStyle())),
                  DropdownButton<String>(
                    value: dropdownValue,
                    style: primaryTextStyle(),
                    underline: Container(),
                    elevation: 10,
                    icon: Icon(Icons.filter_alt),
                    items: <String>[
                      'All',
                      'Restaurant',
                      'Store',
                      'Coffee',
                      'Market',
                      'Hospital',
                      'Residential',
                      'Office',
                      'Lookout'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          textAlign: TextAlign.end,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                      print(dropdownValue);
                    },
                  )
                ],
              ),
            ),
            NearbyPlacesComponent(
              key: ValueKey(dropdownValue),
              category: dropdownValue,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: rf_primaryColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => MapDialog(
                  lat: latLngPosition.latitude,
                  lng: latLngPosition.longitude,
                  currentLatLng: latLngPosition));
          setState(() {});
        },
        child: Icon(
          Icons.map,
          color: Colors.white,
        ),
      ),
    );
  }
}
