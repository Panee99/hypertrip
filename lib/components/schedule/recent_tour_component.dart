import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/RoomFinderModel.dart';
import 'package:room_finder_flutter/models/tour/joined_tour_response.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/screens/RFHotelDescriptionScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RecentTourComponent extends StatefulWidget {
  final TourDetailResponse recentTour;

  RecentTourComponent({required this.recentTour});

  @override
  State<RecentTourComponent> createState() => _RecentTourComponentState();
}

class _RecentTourComponentState extends State<RecentTourComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          rfCommonCachedNetworkImage(widget.recentTour.thumbnailUrl.validate(),
              width: context.width(), height: 150, fit: BoxFit.cover),
          12.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                      widget.recentTour.title
                          .validate()
                          .substring(0,
                              widget.recentTour.title.validate().indexOf('['))
                          .trim(),
                      style: boldTextStyle())
                  .paddingOnly(left: 4),
              Row(
                children: [
                  Text(widget.recentTour.adultPrice.toString().validate(),
                      style: boldTextStyle(color: rf_primaryColor)),
                  // Text("${widget.recentTour.rentDuration.validate()}",
                  //     style: secondaryTextStyle()),
                ],
              ),
            ],
          ),
          8.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Row(
              //   children: [
              //     Icon(Icons.location_on, color: rf_primaryColor, size: 16),
              //     8.width,
              //     // Text(widget.recentTour.location.validate(),
              //     //     style: secondaryTextStyle()),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Text(widget.recentTour.description.validate(),
              //         style: secondaryTextStyle()),
              //     // Text(widget.recentTour.views.validate(),
              //     //     style: secondaryTextStyle()),
              //   ],
              // ),
            ],
          ),
          // 8.height,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     2.width,
          //     Container(
          //       decoration: boxDecorationWithRoundedCorners(
          //           boxShape: BoxShape.circle,
          //           backgroundColor:
          //               recentUpdateData.color ?? greenColor),
          //       padding: EdgeInsets.all(4),
          //     ),
          //     11.width,
          //     Text(recentUpdateData.address.validate(),
          //         style: secondaryTextStyle()),
          //   ],
          // ).paddingOnly(left: 2),
        ],
      ),
    ).onTap(() {
      // RFHotelDescriptionScreen(hotelData: recentUpdateData)
      //     .launch(context);
    },
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent);
    ;
  }
}
