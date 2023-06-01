import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/routers.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/app_languages.dart';
import 'package:room_finder_flutter/widget/rf_tour_item.dart';

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
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(Routers.TOUR_LIST),
              child: Text(
                rf_lang_see_all,
                style: TextStyle(color: rf_primaryColor),
              ),
            ),
          ],
        ),
        16.height,
        RFTourItem(),
      ],
    ).paddingRight(16);
  }
}
