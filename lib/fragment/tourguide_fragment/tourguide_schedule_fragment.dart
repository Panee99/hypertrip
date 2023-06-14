import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/components/schedule/location_tracking_component.dart';
import 'package:room_finder_flutter/components/schedule/recent_tour_component.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
// import 'package:room_finder_flutter/models/RoomFinderModel.dart';
import 'package:room_finder_flutter/models/tour/joined_tour_response.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

import '../../models/tour/current_group_response.dart';
import '../../screens/tour/TourDetailScreen.dart';
import '../../utils/RFImages.dart';

class ScheduleFragment extends StatefulWidget {
  @override
  _ScheduleFragmentState createState() => _ScheduleFragmentState();
}

class _ScheduleFragmentState extends State<ScheduleFragment> {
  late Future<CurrentGroupResponse> currentGroup;
  late Future<TourDetailResponse> tourDetail;
  late AuthProvider authProvider;
  int selectCategoryIndex = 0;

  bool locationWidth = true;

  @override
  void initState() {
    authProvider = context.read<AuthProvider>();
    super.initState();
    tourDetail = getTourDetail(authProvider.token);
    init();
  }

  void init() async {
    setStatusBarColor(rf_primaryColor,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<CurrentGroupResponse> getRecentTour(
      String travelerId, String token) async {
    currentGroup = AppRepository().getCurrentGroup(travelerId, token);
    return currentGroup;
  }

  Future<TourDetailResponse> getTourDetail(String token) async {
    currentGroup = getRecentTour(authProvider.user.id.toString(), token);
    TourDetailResponse tourDetail = await AppRepository().getTourDetail(
        currentGroup.then((group) => group.tourVariant!.tourId).toString());
    return tourDetail;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentGroupResponse>(
        future: currentGroup,
        builder: (BuildContext context,
            AsyncSnapshot<CurrentGroupResponse> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ticket,
                      width: 300,
                      height: 300,
                    ),
                    Text(
                      'No tours have been booked yet...',
                      style: primaryTextStyle(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            final group = snapshot.data!;
            return Scaffold(
              body: Stack(
                children: [
                  LocationTrackingComponent(
                    tourId: group.tourVariant!.tourId.validate(),
                  ),
                  Positioned(
                    bottom: 32, // Adjust the position of the button as needed
                    right: context.width() / 2 -
                        50, // Adjust the position of the button as needed
                    child: AppButton(
                      width: 100,
                      color: secondaryColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      text: "Detail",
                      onTap: () {
                        TourDetailScreen(
                                tourId: group.tourVariant!.tourId.validate())
                            .launch(context);
                      },
                      textStyle: boldTextStyle(color: Colors.white),
                      child: Row(children: [
                        SvgPicture.asset(
                          info,
                          width: 20,
                          color: whiteColor,
                        ),
                        8.width,
                        Text(
                          'Detail',
                          style: primaryTextStyle(color: whiteColor),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
