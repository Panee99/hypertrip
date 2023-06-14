import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/utils/app_languages.dart';
import 'package:room_finder_flutter/widget/rf_tour_item.dart';

class RFUpcomingListTour extends StatelessWidget {
  const RFUpcomingListTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rf_lang_list_comming_tour,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        16.height,
        RFTourItem(),
        8.height,
        RFTourItem(),
        8.height,
        RFTourItem(),
      ],
    ).paddingRight(16);
  }
}
