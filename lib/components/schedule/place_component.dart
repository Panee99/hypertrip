import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/goolge/google_place_detail_response.dart';
import 'package:room_finder_flutter/models/goolge/google_search_place_response.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';

class LocationComponent extends StatefulWidget {
  final TourFlows? tourFlow;
  final bool? locationWidth;

  LocationComponent({required this.tourFlow, this.locationWidth});

  @override
  State<LocationComponent> createState() => _LocationComponentState();
}

class _LocationComponentState extends State<LocationComponent> {
  late Future<Image> photo;
  late List<Future<Widget>> photoList = [];
  late Future<GooglePlaceDetailResponse?> placeDetail;
  @override
  void initState() {
    super.initState();
    placeDetail = getPlaceDetail();
    getPlacePhoto();
  }

  Future<GoogleSearchPlaceResponse?> getPlaces() async {
    final location = await GoogleRepository().getSearchPlaceByCoordinate(
        widget.tourFlow!.latitude!, widget.tourFlow!.longitude!);
    if (location != null) {
      return location;
    } else {
      return null;
    }
  }

  Future<GooglePlaceDetailResponse?> getPlaceDetail() async {
    final locationDetail = await GoogleRepository().getPlaceDetail(
        getPlaces().then((place) => place!.results!.first.placeId).toString());
    if (locationDetail != null) {
      return locationDetail;
    } else {
      return null;
    }
  }

  void getPlacePhoto() async {
    var photos = getPlaceDetail().then((detail) => detail!.result!.photos);
    if (await photos.then((value) => value!.isNotEmpty)) {
      photos.then((photos) => photos!.forEach((photo) {
            photoList.add(GoogleRepository()
                .getPlacePhoto(photo.photoReference.toString()));
          }));
    }
    // getPlaceDetail().then((detail) => detail!.result!.photos!.forEach((photo) {
    //       photos.add(GoogleRepository()
    //           .getPlacePhoto(photo.photoReference.toString()));
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    return photoList.length > 0
        ? Stack(
            children: [
              // rfCommonCachedNetworkImage(
              //   tourFlow.latitude,
              //   fit: BoxFit.cover,
              //   height: 170,
              //   width: widget.locationWidth.validate()
              //       ? context.width()
              //       : context.width() * 0.47 - 16,
              // ),
              FutureBuilder<Widget>(
                future: GoogleRepository().getPlacePhoto(getPlaceDetail()
                    .then((value) => value!.result!.photos!.first)
                    .toString()),
                builder:
                    (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: context.height() * 0.5,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    Widget photoWidget = snapshot.data!;
                    return photoWidget;
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              Container(
                height: 170,
                width: widget.locationWidth.validate()
                    ? context.width()
                    : context.width() * 0.47 - 16,
                decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: black.withOpacity(0.2)),
              ),
              // Positioned(
              //   bottom: 16,
              //   left: 16,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         children: [
              //           Icon(Icons.location_on, color: white, size: 18),
              //           8.width,
              //           Text(tourDetails.destination.toString(),
              //               style: boldTextStyle(color: white)),
              //         ],
              //       ),
              //       4.height,
              //       Text(tourDetails.adultPrice.toString(),
              //               style: secondaryTextStyle(color: white))
              //           .paddingOnly(left: 4),
              //     ],
              //   ),
              // ),
            ],
          )
        : SizedBox.shrink();
  }
}
