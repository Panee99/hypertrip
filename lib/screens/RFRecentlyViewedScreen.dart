import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/components/RFPremiumServiceComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/TourFinderModel.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFRecentlyViewedScreen extends StatelessWidget {
  final List<TourFinderModel> hotelListData = tourList();
  final bool showHeight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context,
          showLeadingIcon: true,
          title: 'Recently Viewed',
          roundCornerShape: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            24.height,
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: hotelListData.length,
              itemBuilder: (BuildContext context, int index) {
                // return RFHotelListComponent(
                //     hotelData: hotelListData[index], showHeight: true);
              },
            ),
            Container(
              margin: EdgeInsets.all(16),
              decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: appStore.isDarkModeOn
                      ? scaffoldDarkColor
                      : rf_selectedCategoryBgColor),
              padding: EdgeInsets.all(16),
              child: RFPremiumServiceComponent(),
            ),
          ],
        ),
      ),
    );
  }
}
