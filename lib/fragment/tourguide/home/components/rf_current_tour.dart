import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/tourguide/home/components/rf_current_tour_item.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/app_languages.dart';

class RFCurrentTour extends StatelessWidget {
  const RFCurrentTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              rf_lang_current_tour,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              rf_lang_see_all,
              style: TextStyle(color: rf_primaryColor),
            ),
          ],
        ),
        16.height,
        RFCurrentTourItem(),
      ],
    ).paddingRight(16);
  }
}
