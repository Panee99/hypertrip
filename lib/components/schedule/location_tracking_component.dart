import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/models/tour/tour_flow_response.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';

import '../../utils/RFDataGenerator.dart';

class LocationTrackingComponent extends StatefulWidget {
  final String tourId;
  const LocationTrackingComponent({super.key, required this.tourId});

  @override
  State<LocationTrackingComponent> createState() =>
      _LocationTrackingComponentState();
}

class _LocationTrackingComponentState extends State<LocationTrackingComponent> {
  late GoogleMapController mapController;
  late Future<Position> latLngPosition;
  late Future<List<TourFlowResponse>> tourFlow;
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
  String googleApiKey = 'AIzaSyAPZiYIlR-ztOa6maus6urUhs1Z-6spyj4';

  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    latLngPosition = _getCurrentLocation();
    tourFlow = getTourFlow(widget.tourId);
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

  Future<List<TourFlowResponse>> getTourFlow(String tourId) async {
    final tourFlow = await AppRepository().getTourFlow(tourId);
    return tourFlow;
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
    List<PolylineWayPoint> wayPoints = [];
    var _tourFlow = await tourFlow;
    if (_tourFlow != null) {
      _tourFlow = _tourFlow
          .where((tour) => tour.latitude != null && tour.longitude != null)
          .toList();
      List<TourFlowResponse> tourSubList =
          _tourFlow.toList().sublist(1, _tourFlow.toList().length - 1);
      tourSubList.toList().asMap().forEach((index, value) {
        PolylineWayPoint wayPoint = PolylineWayPoint(
          location: '${value.latitude},${value.longitude}',
          stopOver: true, // Specify if this waypoint is a stopover or not
        );

        // Add the waypoint to the list
        wayPoints.add(wayPoint);
      });
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey,
          PointLatLng(_tourFlow.first.latitude!, _tourFlow.first.longitude!),
          PointLatLng(_tourFlow.last.latitude!, _tourFlow.last.longitude!),
          travelMode: TravelMode.walking,
          wayPoints: wayPoints);
      print('Status: ' + result.status.toString());
      print('Points: ' + result.points.toString());
      if (result.points.isNotEmpty) {
        setState(() {
          result.points.forEach((PointLatLng point) =>
              _polylineCoordinate.add(LatLng(point.latitude, point.longitude)));
        });
      }
      ;
    }
  }

  void getPolypoints() async {
    var _tourFlow = await tourFlow;
    if (tourFlow != null) {
      _tourFlow = _tourFlow
          .where((tour) => tour.latitude != null && tour.longitude != null)
          .toList();
      _tourFlow.reversed.toList().asMap().forEach((index, position) async {
        Uint8List canvas = await getBytesFromCanvas(_tourFlow.length - index);
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

  void setCustomMarkerIcon() async {
    final String imagePath = location;
    final Color iconColor = secondaryColor; // Set your desired color here

    final ByteData imageData = await rootBundle.load(imagePath);
    final Uint8List bytes = imageData.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();

    final ui.Image image = frameInfo.image;
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Paint paint = Paint()
      ..colorFilter = ColorFilter.mode(iconColor, BlendMode.srcIn);
    canvas.drawImage(image, Offset.zero, paint);

    final Picture picture = pictureRecorder.endRecording();
    final ui.Image coloredImage = await picture.toImage(
        imageSize.width.toInt(), imageSize.height.toInt());

    final ByteData? coloredImageData =
        await coloredImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List coloredBytes = coloredImageData!.buffer.asUint8List();

    currentLocationIcon = BitmapDescriptor.fromBytes(coloredBytes);
    // BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, location)
    //     .then((icon) => currentLocationIcon = icon);
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
                      color: secondaryColor,
                      width: 5)
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                markers: _markers);
          }
        });
  }
}
