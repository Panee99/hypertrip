import 'dart:convert';
import 'package:flutter/material.dart' as Material;
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/discovery/place_detail_component.dart';
import 'package:room_finder_flutter/models/discovery/nearby_response.dart';
import 'package:room_finder_flutter/models/discovery/place_photo_response.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
<<<<<<< Updated upstream:lib/screens/place_details_screen.dart
import 'package:http/http.dart' as http;
import '../utils/QueryString.dart';
=======
>>>>>>> Stashed changes:lib/screens/discovery/place_details_screen.dart

class PlaceDetailsScreen extends StatefulWidget {
  final NearbyResults place;
  final List<PlacesPhotoResponse> photos;

  PlaceDetailsScreen({required this.place, required this.photos});

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: AppButton(
      //   color: rf_primaryColor,
      //   elevation: 0,
      //   child: Text('Book Now', style: boldTextStyle(color: white)),
      //   width: context.width(),
      //   onTap: () {
      //     showInDialog(context, barrierDismissible: true, builder: (context) {
      //       return RFCongratulatedDialog();
      //     });
      //   },
      // ).paddingSymmetric(horizontal: 16, vertical: 24),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Material.Icon(Icons.arrow_back_ios_new,
                    color: white, size: 18),
                onPressed: () {
                  finish(context);
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              backgroundColor: rf_primaryColor,
              pinned: true,
              elevation: 2,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                titlePadding: EdgeInsets.all(10),
                centerTitle: true,
                background: Stack(
                  children: [
                    rfCommonCachedNetworkImage(
                      widget.photos.isNotEmpty
                          ? '${widget.photos[0].prefix}original${widget.photos[0].suffix}'
                          : '',
                      fit: BoxFit.cover,
                      width: context.width(),
                      height: 350,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.place.categories!.first.name.validate(),
                              style: boldTextStyle(color: white, size: 18)),
                          8.height,
                          // Row(
                          //   children: [
                          //     Text("${widget.hotelData!.price.validate()} ",
                          //         style: boldTextStyle(color: white)),
                          //     Text(widget.hotelData!.rentDuration.validate(),
                          //         style: secondaryTextStyle(color: white)),
                          //   ],
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              PlaceDetailComponent(place: widget.place, photos: widget.photos),
            ],
          ),
        ),
      ),
    );
  }
}
