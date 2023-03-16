import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/map_dialog_component.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/RoomFinderModel.dart';
import 'package:room_finder_flutter/models/map/nearby_response.dart';
import 'package:room_finder_flutter/models/map/place_photo_response.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:flutter/material.dart' as Material;

class PlaceDetailComponent extends StatefulWidget {
  final Results place;
  final List<PlacesPhotoResponse> photos;

  PlaceDetailComponent({required this.place, required this.photos});

  @override
  State<PlaceDetailComponent> createState() => _PlaceDetailComponentState();
}

class _PlaceDetailComponentState extends State<PlaceDetailComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              children: [
                // rfCommonCachedNetworkImage(rf_user,
                //         width: 60, height: 60, fit: BoxFit.cover)
                //     .cornerRadiusWithClipRRect(30),
                // 16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.place.name}', style: boldTextStyle()),
                    // 4.height,
                    // Text('Landlord', style: secondaryTextStyle()),
                  ],
                ).expand(),

                // 8.width,
                // AppButton(
                //   onTap: () {
                //     launchMail("demo@gmail.com");
                //   },
                //   color: rf_primaryColor,
                //   width: 15,
                //   height: 15,
                //   elevation: 0,
                //   child: rf_message.iconImage(iconColor: white, size: 14),
                // ),
              ],
            ),
            24.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material.Icon(Icons.location_on, color: rf_primaryColor)
                    .paddingOnly(top: 2),
                16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.place.distance} meters away',
                        style: boldTextStyle()),
                    8.height,
                    Text('${widget.place.location!.address}',
                        style: primaryTextStyle()),
                    // 8.height,
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Text('0 Applied',
                    //             style: boldTextStyle(
                    //                 color: appStore.isDarkModeOn
                    //                     ? white
                    //                     : rf_textColor))
                    //         .flexible(),
                    //     4.width,
                    //     Container(
                    //         height: 16, width: 1, color: context.iconColor),
                    //     4.width,
                    //     Text('19 Views',
                    //             style: boldTextStyle(
                    //                 color: appStore.isDarkModeOn
                    //                     ? white
                    //                     : rf_textColor))
                    //         .flexible(),
                    //   ],
                    // )
                  ],
                ).expand(),
                16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Row(
                    //   children: [
                    //     Container(
                    //       padding: EdgeInsets.all(4),
                    //       decoration: boxDecorationWithRoundedCorners(
                    //           backgroundColor: hotelData!.color!,
                    //           boxShape: BoxShape.circle),
                    //     ),
                    //     6.width,
                    //     Text(hotelData!.address.validate(),
                    //         style: secondaryTextStyle()),
                    //   ],
                    // ),
                    // 8.height,
                    // Text(
                    //   'Property Owned By: Alok',
                    //   style: primaryTextStyle(),
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    // ).paddingOnly(left: 2),
                    // 8.height,
                    // Text(
                    //   'View on Google Maps',
                    //   style: primaryTextStyle(
                    //       color: appStore.isDarkModeOn ? white : rf_textColor,
                    //       decoration: TextDecoration.underline),
                    // ).paddingOnly(left: 2),
                    AppButton(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => (MapDialog(
                                  lat: widget.place.geocodes!.main!.latitude,
                                  lng: widget.place.geocodes!.main!.longitude,
                                )));
                        setState(() {});
                      },
                      color: rf_primaryColor,
                      width: 5,
                      height: 5,
                      elevation: 0,
                      child: Material.Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ).expand()
              ],
            ),
          ],
        ).paddingAll(24),
        HorizontalList(
          padding: EdgeInsets.only(right: 24, left: 24),
          wrapAlignment: WrapAlignment.spaceEvenly,
          itemCount: widget.photos.length,
          itemBuilder: (_, int index) => Stack(
            alignment: Alignment.center,
            children: [
              rfCommonCachedNetworkImage(
                  '${widget.photos[index].prefix}100x100${widget.photos[index].suffix}',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover),
              // Container(
              //   height: 70,
              //   width: 70,
              //   decoration: boxDecorationWithRoundedCorners(
              //     borderRadius: BorderRadius.circular(8),
              //     backgroundColor: black.withOpacity(0.5),
              //   ),
              // ),
              // Text('+ 5',
              //         style: boldTextStyle(color: white, size: 20),
              //         textAlign: TextAlign.center)
              //     .visible(index == 3),
            ],
          ),
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text('Description', style: boldTextStyle()),
        //     8.height,
        //     Text(
        //       '1 big hall room for rent at lalitpur, ktm with the facilities of bike parking and tap water . it offers 1 bedroom,and a 1 common bathroom for whole flat. It is suitable for student only. Price is negotiable for student only. ',
        //       style: secondaryTextStyle(),
        //     ),
        //     24.height,
        //     Text('Facilities', style: boldTextStyle()),
        //     16.height,
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Row(
        //               children: [
        //                 Material.Icon(Icons.done,
        //                     size: 16, color: rf_primaryColor),
        //                 8.width,
        //                 Text('1 Big Hall', style: secondaryTextStyle()),
        //               ],
        //             ),
        //             4.height,
        //             Row(
        //               children: [
        //                 Material.Icon(Icons.done,
        //                     size: 16, color: rf_primaryColor),
        //                 8.width,
        //                 Text('Bikes and Car Parking ',
        //                     style: secondaryTextStyle()),
        //               ],
        //             ),
        //           ],
        //         ),
        //         Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Row(
        //               children: [
        //                 Material.Icon(Icons.done,
        //                     size: 16, color: rf_primaryColor),
        //                 8.width,
        //                 Text('Shared Toilet', style: secondaryTextStyle()),
        //               ],
        //             ),
        //             4.height,
        //             Row(
        //               children: [
        //                 Material.Icon(Icons.done,
        //                     size: 16, color: rf_primaryColor),
        //                 8.width,
        //                 Text('24/7 Water facility',
        //                     style: secondaryTextStyle()),
        //               ],
        //             ),
        //           ],
        //         )
        //       ],
        //     ),
        //   ],
        // ).paddingOnly(left: 24, right: 24, top: 24, bottom: 8),
      ],
    );
  }
}
