import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/TourFinderModel.dart';
import 'package:room_finder_flutter/screens/RFHotelDescriptionScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../models/tour/tour_detail_response.dart';
import '../models/tour/tour_list_response.dart';

class RFHotelListComponent extends StatelessWidget {
  Future<TourDetailResponse>? listTour;
  final TourListModels? tourListData;
  final bool? showHeight;

  RFHotelListComponent({this.tourListData, this.showHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration:
          boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rfCommonCachedNetworkImage(tourListData!.thumbnailUrl.validate(),
                  height: 100, width: 100, fit: BoxFit.cover)
              .cornerRadiusWithClipRRect(8),
          16.width,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tourListData!.title.validate(),
                          style: boldTextStyle()),
                      8.height,
                      Row(
                        children: [
                          Text(tourListData!.adultPrice.toString(),
                              style: boldTextStyle(color: rf_primaryColor)),
                          // Text(tourListData!.description.validate(),
                          //     style: secondaryTextStyle()),
                        ],
                      )
                    ],
                  ).expand(),
                  Row(
                    children: [
                      // Container(
                      //   decoration: boxDecorationWithRoundedCorners(
                      //       boxShape: BoxShape.circle,
                      //       backgroundColor: tourListData!.color ?? greenColor),
                      //   padding: EdgeInsets.all(4),
                      // ),
                      6.width,
                      Text(tourListData!.departure.validate(),
                          style: secondaryTextStyle()),
                    ],
                  ),
                ],
              ).paddingOnly(left: 3),
              showHeight.validate() ? 8.height : 24.height,
              Row(
                children: [
                  Icon(Icons.location_on, color: rf_primaryColor, size: 16),
                  6.width,
                  Text(tourListData!.destination.validate(),
                      style: secondaryTextStyle()),
                ],
              ),
            ],
          ).expand()
        ],
      ),
    ).onTap(() {
      // RFHotelDescriptionScreen(hotelData: tourListData.id).launch(context);
    },
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent);
  }
}
