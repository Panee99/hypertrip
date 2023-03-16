import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
// import 'package:room_finder_flutter/bloc/bloc.dart';
// import 'package:room_finder_flutter/bloc/event.dart';
import 'package:room_finder_flutter/bloc/nearby/nearby_event.dart';
import 'package:room_finder_flutter/bloc/nearby/nearby_bloc.dart';
// import 'package:room_finder_flutter/bloc/nearby/state.dart';
import 'package:room_finder_flutter/components/place_list_component.dart';
import 'package:room_finder_flutter/models/map/nearby_response.dart';
import 'package:room_finder_flutter/models/map/place_photo_response.dart';
import 'package:room_finder_flutter/repos/repositories.dart';
import 'package:room_finder_flutter/utils/QueryString.dart';
import 'package:room_finder_flutter/utils/network.dart';
import '../bloc/nearby/nearby_state.dart';
import '../utils/QueryString.dart';
import '../utils/RFColors.dart';

class NearbyPlacesComponent extends StatefulWidget {
  String category;
  NearbyPlacesComponent({super.key, required this.category});

  @override
  State<NearbyPlacesComponent> createState() => _NearbyPlacesComponentState();
}

class _NearbyPlacesComponentState extends State<NearbyPlacesComponent> {
  late Future<NearbyPlacesResponse> nearbyPlacesResponse;
  late Future<NearbyPlacesResponse> nearbyPlacesByCategory;
  Results results = Results();
  PlacesPhotoResponse placePhoto = PlacesPhotoResponse();
  double lat = 0.0, lon = 0.0;

  @override
  void initState() {
    super.initState();
    // nearbyPlacesResponse = getNearbyPlaces();
  }

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
    print('Category: ${widget.category}');
    return NearbyPlacesResponse.fromJson(jsonDecode(response.body));
  }

  // void getNearbyPlacesByCategory(
  //     NearbyPlacesResponse nearbyPlacesResponse, String category) async {
  //   for (var i = 0; i < nearbyPlacesResponse.results!.length; i++) {
  //     if (nearbyPlacesResponse.results![i].categories!.contains(category)) {
  //       nearbyPlacesByCategory =
  //           nearbyPlacesResponse.results![i].toJson();
  //     }
  //   }
  //   setState(() {});
  // }
  // print(
  //     'Tọa độ: ${position.latitude.toString()}, ${position.longitude.toString()}');
  // print('Status:  ${response.statusCode}');
  // print('Response body: ${response.body}');
  // print('So luong dia diem: ${nearbyPlacesResponse.results}');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceBloc, PlaceState>(builder: (context, state) {
      if (state is PlaceLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is PlaceLoadedState) {
        NearbyPlacesResponse places = state.places;
        print('${places}');
        return Center(
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: places.results!.length,
            itemBuilder: (BuildContext context, int index) {
              try {
                if (widget.category == 'All') {
                  if (places.results![index].categories != null &&
                      !places.results![index].categories!.isEmpty) {
                    Results results = places.results![index];

                    return PlaceListComponent(
                      placeNearby: results,
                      photoIndex: 0,
                    );
                  }
                } else {
                  for (var i = 0;
                      i < places.results![index].categories!.length;) {
                    if (places.results![index].categories![i].name!
                        .contains(widget.category)) {
                      Results results = places.results![index];
                      return PlaceListComponent(
                        placeNearby: results,
                        photoIndex: 0,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }
                }
              } catch (e) {
                print(e.toString());
              }
              return null;
            },
          ),
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }
  // Column(
  //   children: [
  //     if (nearbyPlacesResponse.results != null)
  //       for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
  //         NearbyPlaceWidget(nearbyPlacesResponse.results![i])
  //   ],
  // );
}
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<NearbyPlacesResponse>(
//         future: nearbyPlacesResponse,
//         builder: (BuildContext context,
//             AsyncSnapshot<NearbyPlacesResponse> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return SizedBox(
//               height: context.height() * 0.5,
//               child: Center(child: CircularProgressIndicator()),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (snapshot.hasData) {
//             final nearbyPlaces = snapshot.data!;
//             return ListView.builder(
//               shrinkWrap: true,
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               physics: NeverScrollableScrollPhysics(),
//               scrollDirection: Axis.vertical,
//               itemCount: nearbyPlaces.results!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 try {
//                   if (widget.category == 'All') {
//                     if (nearbyPlaces.results![index].categories != null &&
//                         !nearbyPlaces.results![index].categories!.isEmpty) {
//                       Results results = nearbyPlaces.results![index];

//                       return PlaceListComponent(
//                         placeNearby: results,
//                         photoIndex: 0,
//                       );
//                     }
//                   } else {
//                     for (var i = 0;
//                         i < nearbyPlaces.results![index].categories!.length;) {
//                       if (nearbyPlaces.results![index].categories![i].name!
//                           .contains(widget.category)) {
//                         Results results = nearbyPlaces.results![index];
//                         return PlaceListComponent(
//                           placeNearby: results,
//                           photoIndex: 0,
//                         );
//                       } else {
//                         return SizedBox.shrink();
//                       }
//                     }
//                   }
//                 } catch (e) {
//                   print(e.toString());
//                 }
//                 return null;
//               },
//             );
//           } else {
//             return SizedBox.shrink();
//           }
//         });
//     // Column(
//     //   children: [
//     //     if (nearbyPlacesResponse.results != null)
//     //       for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
//     //         NearbyPlaceWidget(nearbyPlacesResponse.results![i])
//     //   ],
//     // );
//   }
// }
