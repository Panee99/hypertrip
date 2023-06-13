import 'package:flutter/material.dart';
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

class ScheduleFragment extends StatefulWidget {
  @override
  _ScheduleFragmentState createState() => _ScheduleFragmentState();
}

class _ScheduleFragmentState extends State<ScheduleFragment> {
  // List<RoomFinderModel> categoryData = categoryList();
  // List<RoomFinderModel> hotelListData = hotelList();
  // List<RoomFinderModel> locationListData = locationList();
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
    print('Schedule Fragment');
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
            final group = snapshot.data!;
            return Scaffold(
              body: LocationTrackingComponent(
                tour: tour,
              ),
            );
          }
        });
  }
}
