import 'package:flutter/material.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFRecentUpdateViewAllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          commonAppBarWidget(context, title: 'App Bar', showLeadingIcon: false),
      // body: ListView.builder(
      //   padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 24),
      //   shrinkWrap: true,
      //   scrollDirection: Axis.vertical,
      //   itemCount: 15,
      //   itemBuilder: (BuildContext context, int index) =>
      //       RFRecentUpdateComponent(
      //     recentUpdateData: hotelListData[index % hotelListData.length],
      //   ),
      // ),
    );
  }
}
