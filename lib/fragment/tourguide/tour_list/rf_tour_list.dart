import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/tourguide/tour_list/components/rf_current_tour.dart';
import 'package:room_finder_flutter/fragment/tourguide/tour_list/components/rf_upcoming_list_tour.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

class RFTourList extends StatelessWidget {
  const RFTourList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, backgroundColor: rf_primaryColor),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          RFCurrentTour(),
          16.height,
          RFUpcomingListTour(),
        ],
      ),
    );
  }
}
