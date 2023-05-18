import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:room_finder_flutter/components/schedule/place_component.dart';
import 'package:room_finder_flutter/components/schedule/location_tracking_component.dart';
import 'package:room_finder_flutter/components/schedule/recent_tour_component.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/tour/joined_tour_response.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFString.dart';

class ScheduleFragment extends StatefulWidget {
  @override
  _ScheduleFragmentState createState() => _ScheduleFragmentState();
}

class _ScheduleFragmentState extends State<ScheduleFragment> {
  //List<RoomFinderModel> recentUpdateData = recentUpdateList();
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

  Future<JoinedTourResponse?> getRecentTour(
      String travelerId, String token) async {
    List<JoinedTourResponse>? tourList =
        await AppRepository().getJoinedTour(travelerId, token);
    DateTime now = DateTime.now();
    if (tourList!.isNotEmpty) {
      tourList.sort((a, b) => (DateTime.parse(a.endTime!))
          .difference(now)
          .abs()
          .compareTo(DateTime.parse(b.endTime!).difference(now).abs()));
      return tourList.first;
    } else {
      return null;
    }
  }

  Future<TourDetailResponse> getTourDetail(String token) async {
    JoinedTourResponse? recentTour =
        await getRecentTour(authProvider.user.id.toString(), token);
    TourDetailResponse tourDetail =
        await AppRepository().getTourDetail(recentTour!.id.toString(), token);
    return tourDetail;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TourDetailResponse>(
        future: tourDetail,
        builder:
            (BuildContext context, AsyncSnapshot<TourDetailResponse> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: context.height() * 0.5,
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            final tour = snapshot.data!;
            return Scaffold(
              body: RFCommonAppComponent(
                mainWidgetHeight: 200,
                subWidgetHeight: 50,
                cardWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text('Find a property anywhere', style: boldTextStyle(size: 18)),
                    // 16.height,
                    // AppTextField(
                    //   textFieldType: TextFieldType.EMAIL,
                    //   decoration: rfInputDecoration(
                    //     hintText: "Search address or near you",
                    //     showPreFixIcon: true,
                    //     showLableText: false,
                    //     prefixIcon:
                    //         Icon(Icons.location_on, color: rf_primaryColor, size: 18),
                    //   ),
                    // ),
                    // 16.height,
                    // AppButton(
                    //   color: rf_primaryColor,
                    //   elevation: 0.0,
                    //   child: Text('Search Now', style: boldTextStyle(color: white)),
                    //   width: context.width(),
                    //   onTap: () {
                    //     RFSearchDetailScreen().launch(context);
                    //   },
                    // ),
                    // TextButton(
                    //   onPressed: () {
                    //     //
                    //   },
                    //   child: Align(
                    //     alignment: Alignment.topRight,
                    //     child: Text('Advance Search',
                    //         style: primaryTextStyle(), textAlign: TextAlign.end),
                    //   ),
                    // )
                    SizedBox(
                      child: LocationTrackingComponent(
                        tour: tour,
                      ),
                      width: context.width() * 0.8,
                      height: 300,
                    )
                  ],
                ),
                // subWidget: Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text('Recent Tour', style: boldTextStyle()),
                //       ],
                //     ).paddingOnly(left: 16, right: 16, top: 16, bottom: 8),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 16),
                //       child: RecentTourComponent(recentTour: tour),
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text('Schedule', style: boldTextStyle()),
                //       ],
                //     ).paddingOnly(left: 16, right: 16, bottom: 8),
                //     // Row(
                //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     //   children: [
                //     //     Text('Locations', style: boldTextStyle()),
                //     //     TextButton(
                //     //       onPressed: () {
                //     //         RFLocationViewAllScreen(locationWidth: true)
                //     //             .launch(context);
                //     //       },
                //     //       child: Text('View All',
                //     //           style: secondaryTextStyle(
                //     //               decoration: TextDecoration.underline)),
                //     //     )
                //     //   ],
                //     // ).paddingOnly(left: 16, right: 16, bottom: 8),
                //     // Wrap(
                //     //   spacing: 16,
                //     //   runSpacing: 16,
                //     //   children: List.generate(tour.tourFlows!.length, (index) {
                //     //     return LocationComponent(
                //     //         tourFlow: tour.tourFlows![index]);
                //     //   }),
                //     // ),
                //   ],
                // ),
              ),
            );
          }
        });
  }
}
