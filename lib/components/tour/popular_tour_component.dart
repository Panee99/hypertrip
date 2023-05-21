import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:room_finder_flutter/utils/utilities.dart';

import '../../models/tour/tour_list_response.dart';
import '../../screens/tour/RFHotelDescriptionScreen.dart';

class PopularTourComponent extends StatefulWidget {
  final TourListModels tour;
  const PopularTourComponent({super.key, required this.tour});
  @override
  State<PopularTourComponent> createState() => _PopularTourState();
}

class _PopularTourState extends State<PopularTourComponent> {
  final int rating = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 133,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 117,
                width: 117,
                child: rfCommonCachedNetworkImage(
                    widget.tour.thumbnailUrl.validate(),
                    fit: BoxFit.cover,
                    radius: 20),
              ),
              8.height,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      Utilities.capitalizeWords(
                          widget.tour.title.validate().split('[')[0].trim()),
                      style: boldTextStyle(size: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              8.height,
              Row(
                children: [
                  rating >= 1
                      ? SvgPicture.asset(
                          star,
                          color: starRateColor,
                          height: 8,
                        )
                      : SvgPicture.asset(
                          star,
                          color: starUnrateColor,
                          height: 8,
                        ),
                  rating >= 2
                      ? SvgPicture.asset(
                          star,
                          color: starRateColor,
                          height: 8,
                        )
                      : SvgPicture.asset(
                          star,
                          color: starUnrateColor,
                          height: 8,
                        ),
                  rating >= 3
                      ? SvgPicture.asset(
                          star,
                          color: starRateColor,
                          height: 8,
                        )
                      : SvgPicture.asset(
                          star,
                          color: starUnrateColor,
                          height: 8,
                        ),
                  rating >= 4
                      ? SvgPicture.asset(
                          star,
                          color: starRateColor,
                          height: 8,
                        )
                      : SvgPicture.asset(
                          star,
                          color: starUnrateColor,
                          height: 8,
                        ),
                  rating >= 5
                      ? SvgPicture.asset(
                          star,
                          color: starRateColor,
                          height: 8,
                        )
                      : SvgPicture.asset(
                          star,
                          color: starUnrateColor,
                          height: 8,
                        ),
                ],
              ),
              8.height,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      NumberFormat('#,###')
                              .format(widget.tour.adultPrice!.toInt())
                              .toString()
                              .validate() +
                          ' VND',
                      style: boldTextStyle(size: 12),
                    ),
                  ),
                ],
              )
            ],
          ).paddingAll(8),
        ).onTap(() {
          RFHotelDescriptionScreen(
            tourId: widget.tour.id.validate(),
          ).launch(context);
        }),
      ],
    ).paddingRight(16);
  }
}
