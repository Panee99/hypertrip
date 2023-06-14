import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/components/RFAppliedHotelListComponent.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/TourFinderModel.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFAccountFragment extends StatefulWidget {
  @override
  State<RFAccountFragment> createState() => _RFAccountFragmentState();
}

class _RFAccountFragmentState extends State<RFAccountFragment> {
  final List<TourFinderModel> settingData = settingList();
  final List<TourFinderModel> appliedHotelData = appliedHotelList();
  final List<TourFinderModel> applyHotelData = applyHotelList();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: rf_primaryColor,
        elevation: 0,
      ),
      body: RFCommonAppComponent(
        title: "Account",
        mainWidgetHeight: 200,
        subWidgetHeight: 100,
        accountCircleWidget: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 150),
                width: 100,
                height: 100,
                decoration: boxDecorationWithRoundedCorners(
                    boxShape: BoxShape.circle, border: Border.all(color: white, width: 4)),
                child: rfCommonCachedNetworkImage(rf_user,
                    fit: BoxFit.cover, width: 100, height: 100, radius: 150),
              ),
              Positioned(
                bottom: 8,
                right: -4,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(6),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: context.cardColor,
                    boxShape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0.4,
                          blurRadius: 3,
                          color: gray.withOpacity(0.1),
                          offset: Offset(1, 6)),
                    ],
                  ),
                  child: Icon(Icons.add,
                      color: appStore.isDarkModeOn ? white : rf_primaryColor, size: 16),
                ),
              ),
            ],
          ),
        ),
        subWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Text(authProvider.user.firstName! + ' ' + authProvider.user.lastName!,
                    style: boldTextStyle(size: 18))
                .center(),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('10 Applied', style: secondaryTextStyle()),
                8.width,
                Container(
                    height: 10,
                    width: 1,
                    color: appStore.isDarkModeOn ? white : gray.withOpacity(0.4)),
                8.width,
                Text('Kathmandu', style: secondaryTextStyle()),
              ],
            ),
            32.height,
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    launchCall("1234567890");
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: context.scaffoldBackgroundColor,
                    side: BorderSide(color: context.dividerColor, width: 1),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      rf_call.iconImage(iconColor: appStore.isDarkModeOn ? white : rf_primaryColor),
                      8.width,
                      Text('Call Me',
                          style: boldTextStyle(
                              color: appStore.isDarkModeOn ? white : rf_primaryColor)),
                    ],
                  ),
                ).expand(),
                16.width,
                AppButton(
                  color: rf_primaryColor,
                  elevation: 0.0,
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  width: context.width(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      rf_message.iconImage(iconColor: whiteColor),
                      // rfCommonCachedNetworkImage(rf_message, color: white, height: 16, width: 16),
                      8.width,
                      Text('Message Me', style: boldTextStyle(color: white)),
                    ],
                  ),
                  onTap: () {
                    launchMail("demo@gmail.com");
                  },
                ).expand()
              ],
            ).paddingSymmetric(horizontal: 16),
            Container(
              decoration: boxDecorationWithRoundedCorners(
                border: Border.all(
                    color:
                        appStore.isDarkModeOn ? gray.withOpacity(0.3) : rf_selectedCategoryBgColor),
                backgroundColor: context.cardColor,
              ),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email', style: boldTextStyle()),
                      Text('henry11@gmail.com', style: secondaryTextStyle()),
                    ],
                  ).paddingSymmetric(horizontal: 24, vertical: 16),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Location', style: boldTextStyle()),
                      Text('Kathmandu, Nepal', style: secondaryTextStyle()),
                    ],
                  ).paddingSymmetric(horizontal: 24, vertical: 16),
                  Divider(color: context.dividerColor, height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phone No', style: boldTextStyle()),
                      Text(authProvider.user.phone!, style: secondaryTextStyle()),
                    ],
                  ).paddingSymmetric(horizontal: 24, vertical: 16),
                ],
              ),
            ),
            16.height,
            HorizontalList(
              itemCount: applyHotelData.length,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemBuilder: (_, index) {
                TourFinderModel data = applyHotelData[index];

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor:
                        selectedIndex == index ? rf_selectedCategoryBgColor : Colors.transparent,
                  ),
                  child: Text(
                    data.roomCategoryName.validate(),
                    style: boldTextStyle(
                        color: selectedIndex == index ? rf_primaryColor : gray.withOpacity(0.4)),
                  ),
                ).onTap(() {
                  selectedIndex = index;
                  setState(() {});
                },
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent);
              },
            ),
            ListView.builder(
              padding: EdgeInsets.only(right: 16, left: 16, top: 16),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: appliedHotelData.length,
              itemBuilder: (BuildContext context, int index) {
                TourFinderModel data = appliedHotelData[index];
                return RFAppliedHotelListComponent(appliedHotelList: data);
              },
            ),
          ],
        ),
      ),
    );
  }
}