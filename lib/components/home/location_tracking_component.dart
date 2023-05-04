import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/tour/tour_locations_response.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class LocationTrackingComponent extends StatefulWidget {
  const LocationTrackingComponent({super.key});

  @override
  State<LocationTrackingComponent> createState() =>
      _LocationTrackingComponentState();
}

class _LocationTrackingComponentState extends State<LocationTrackingComponent> {
  late GoogleMapController mapController;
  late Future<Position> latLngPosition;
  late Future<List<TourLocationsResponse>?> tourLocationList;
  late AuthProvider authProvider;
  late StreamSubscription<Position>? _positionStreamSubscription;
  late Timer _timer;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  Position? _position;
  List<LatLng> _polylinePoints = [];
  Set<Marker> _markers = {};

  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    super.initState();
    latLngPosition = _getCurrentLocation();
    tourLocationList = AppRepository().getTourLocations(
        'd1936e4c-9c32-49ae-aa51-0f23089a78d4', authProvider.token);
    setCustomMarkerIcon();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_position != null) {
        setState(() {
          _markers.add(Marker(
              markerId: MarkerId('my_location'),
              position: LatLng(_position!.latitude, _position!.longitude),
              icon: currentLocationIcon));
          _polylinePoints
              .add(LatLng(_position!.latitude, _position!.longitude));
        });
      }
    });
  }

  @override
  void dispose() {
    _stopLocationUpdates();
    _timer.cancel();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await getPolypoints();
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
    // return position;
    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((event) {
      setState(() {
        // _markers.add(Marker(
        //     markerId: MarkerId('my_location'),
        //     position: LatLng(position.latitude, position.longitude)));
        _position = event;
      });
    });
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // mapController.animateCamera(CameraUpdate.newLatLngZoom(
    //     LatLng(position.latitude, position.longitude), 15.0));
    return position;
  }

  void _stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
  }

  Future<void> getPolypoints() async {
    await tourLocationList.then((value) =>
        value!.reversed.toList().asMap().forEach((index, position) async {
          print('Index of tour list: ' + index.toString());
          Uint8List canvas = await getBytesFromCanvas(value.length - index);
          setState(() {
            LatLng latLng = LatLng(
                position.latitude!.toDouble(), position.longitude!.toDouble());
            _markers.add(Marker(
                markerId: MarkerId('tour_location: ' + position.id.toString()),
                position: latLng,
                icon: BitmapDescriptor.fromBytes(canvas),
                anchor: Offset(0.5, 1.0)));
            _polylinePoints.add(latLng);
          });
        }));
    // _updatePolyline();
    ;
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/airplane_marker.png')
        .then((icon) => currentLocationIcon = icon);
  }

  Future<Uint8List> getBytesFromCanvas(int number) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // Set the circle color and size
    final circlePaint = Paint()..color = Colors.blue;
    final circleRadius = 40.0;

    // Set the number color and size
    final numberTextSpan = TextSpan(
      text: number.toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
    final numberTextPainter = TextPainter(
      text: numberTextSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    numberTextPainter.layout();
    final numberOffset = Offset(
      circleRadius - numberTextPainter.width / 2,
      circleRadius - numberTextPainter.height / 2,
    );

    // Set the point color and size
    final pointPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;
    final pointStart = Offset(
      circleRadius,
      circleRadius + 15.0,
    );
    final pointEnd = Offset(
      circleRadius,
      circleRadius + 60.0,
    );

    // Draw the circle, number, and point on the canvas
    canvas.drawCircle(
      Offset(circleRadius, circleRadius),
      circleRadius,
      circlePaint,
    );
    numberTextPainter.paint(canvas, numberOffset);
    canvas.drawLine(pointStart, pointEnd, pointPaint);

    // Convert the canvas to an image and return its bytes
    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(
      (circleRadius * 2).toInt(),
      ((circleRadius * 2) + 50.0).toInt(),
    );
    final pngBytes = await img.toByteData(format: ImageByteFormat.png);
    return pngBytes!.buffer.asUint8List();
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
                // myLocationEnabled: true,
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
