import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/ui/guide/home/components/rf_category.dart';
import 'package:room_finder_flutter/ui/guide/home/components/rf_current_tour.dart';
import 'package:room_finder_flutter/ui/guide/home/components/rf_tourguide_appbar.dart';

class RFHomeTourGuideFragment extends StatelessWidget {
  const RFHomeTourGuideFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RFTourGuideAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          RFCategory(),
          RFCurrentTour(),
        ],
      ).paddingOnly(left: 16, top: 32),
    );
  }
}
