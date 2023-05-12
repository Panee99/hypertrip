import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

class LocationTrackingComponent extends StatefulWidget {
  final TourDetailResponse tour;
  const LocationTrackingComponent({super.key, required this.tour});

  @override
  State<LocationTrackingComponent> createState() =>
      _LocationTrackingComponentState();
}

class _LocationTrackingComponentState extends State<LocationTrackingComponent> {
  late GoogleMapController mapController;
  late Future<Position> latLngPosition;
  late List<TourFlows>? tourFlow;
  late AuthProvider authProvider;
  late StreamSubscription<Position>? _positionStreamSubscription;
  late Timer _timer;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  Position? _position;
  List<LatLng> _polylineCoordinate = [];
  Set<Marker> _markers = {};
  // Set<Polyline> polylines = {};
  MapsRoutes route = new MapsRoutes();
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  String googleApiKey = 'AIzaSyAvMnrp-xOiyWA0rMaxLFNgqLQiP7ZtKiQ';
  String totalDistance = 'No route';

  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    latLngPosition = _getCurrentLocation();
    tourFlow = widget.tour.tourFlows;
    setCustomMarkerIcon();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_position != null) {
        setState(() {
          _markers.add(Marker(
              markerId: MarkerId('my_location'),
              position: LatLng(_position!.latitude, _position!.longitude),
              icon: currentLocationIcon));
        });
      }
    });
    getPolypoints();
    // getCoordinate();
    getDirection();
    super.initState();
  }

  @override
  void dispose() {
    _stopLocationUpdates();
    _timer.cancel();
    super.dispose();
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

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void getDirection() async {
    PolylinePoints polylinePoints = PolylinePoints();

    // if (tourFlow != null) {
    //   tourFlow!.reversed.toList().asMap().forEach((index, position) async {
    //     setState(() {
    //       LatLng latLng = LatLng(
    //           position.latitude!.toDouble(), position.longitude!.toDouble());
    //       _polylineCoordinate.add(latLng);
    //     });
    //   });
    // }
    // await route.drawRoute(
    //     _polylineCoordinate, 'Test routes', rf_primaryColor, googleApiKey,
    //     travelMode: TravelModes.driving);
    // setState(() {
    //   totalDistance = distanceCalculator
    //       .calculateRouteDistance(_polylineCoordinate, decimals: 1);
    // });
    // print('Polyline Coordinate: ' + _polylineCoordinate.length.toString());
    // print('Route: ' + route.routes.length.toString());
    if (tourFlow != null) {
      tourFlow!.reversed.toList().asMap().forEach((index, place) async {
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            googleApiKey,
            PointLatLng(tourFlow!.elementAt(index).latitude!,
                tourFlow!.elementAt(index).longitude!),
            PointLatLng(tourFlow!.elementAt(index + 1).latitude!,
                tourFlow!.elementAt(index + 1).longitude!),
            travelMode: TravelMode.bicycling);
        if (result.points.isNotEmpty) {
          setState(() {
            result.points.forEach((PointLatLng point) => _polylineCoordinate
                .add(LatLng(point.latitude, point.longitude)));
          });
          print('Polyline Result Status: ' + result.status.toString());
          print('Polyline Result: ' + result.points.length.toString());
        }
      });
    }
    // String apiUrl = 'https://maps.googleapis.com/maps/api/directions/json?'
    //     'origin=${tourFlow!.first.latitude},${tourFlow!.first.longitude}&'
    //     'destination=${tourFlow!.elementAt(1).latitude},${tourFlow!.elementAt(1).longitude}&'
    //     'key=${googleApiKey}';

    // var response = await http.get(Uri.parse(apiUrl));
    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body);

    //   List<PointLatLng> result = polylinePoints.decodePolyline(
    //       jsonResponse['routes'][0]['overview_polyline']['points']);
    //   _polylineCoordinate.clear();
    //   if (result.isNotEmpty) {
    //     result.forEach((PointLatLng point) {
    //       _polylineCoordinate.add(LatLng(point.latitude, point.longitude));
    //     });
    //     print('Result: ' + result.length.toString());
    //   } else {
    //     print('Result: ' + result.first.latitude.toString());
    //   }
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }

  void getPolypoints() async {
    if (tourFlow != null) {
      tourFlow!.reversed.toList().asMap().forEach((index, position) async {
        Uint8List canvas = await getBytesFromCanvas(tourFlow!.length - index);
        setState(() {
          LatLng latLng = LatLng(
              position.latitude!.toDouble(), position.longitude!.toDouble());
          _markers.add(Marker(
              markerId: MarkerId('tour_location: ' + position.id.toString()),
              position: latLng,
              icon: BitmapDescriptor.fromBytes(canvas),
              anchor: Offset(0.5, 1.0)));
        });
      });
    }

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
                polylines:
                    // route.routes,

                    {
                  Polyline(
                      polylineId: PolylineId('route'),
                      points: _polylineCoordinate,
                      color: rf_primaryColor,
                      width: 6)
                },
                // myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                markers: _markers);
          }
        });
  }
}
