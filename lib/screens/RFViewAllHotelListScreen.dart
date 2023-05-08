import 'package:flutter/material.dart';
import 'package:room_finder_flutter/components/RFHotelListComponent.dart';
import 'package:room_finder_flutter/models/TourFinderModel.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../data/repositories/repositories.dart';
import '../models/tour/tour_detail_response.dart';

class RFViewAllHotelListScreen extends StatefulWidget {
  const RFViewAllHotelListScreen({super.key});

  @override
  State<RFViewAllHotelListScreen> createState() =>
      _RFViewAllHotelListScreenState();
}

class _RFViewAllHotelListScreenState extends State<RFViewAllHotelListScreen> {
  Future<List<TourDetailResponse>>? listTour;
  final List<TourFinderModel> hotelListData = tourList();
  void getTourList() {
    listTour = AppRepository().getTourList('1', '10');
  }

  @override
  void initState() {
    super.initState();
    getTourList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(context,
          title: "Tour List",
          appBarHeight: 80,
          showLeadingIcon: false,
          roundCornerShape: true),
      // body: FutureBuilder<List<TourDetailResponse>>(
      // future: listTour,
      // builder: (BuildContext context,
      //     AsyncSnapshot<List<TourDetailResponse>> snapshot) {
      //   if (!snapshot.hasData) {
      //     return SizedBox(
      //       // height: context.height() * 0.5,
      //       child: Center(child: CircularProgressIndicator()),
      //     );
      //   } else {
      //     final tours = snapshot.data!;
      //   }
      // },
      // ),

      //body: ListView.builder(
      //   padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 24),
      //   shrinkWrap: true,
      //   scrollDirection: Axis.vertical,
      //   itemCount: 20,
      //   itemBuilder: (BuildContext cont ext, int index) {
      //     TourFinderModel data = hotelListData[index % hotelListData.length];
      //     return RFHotelListComponent(hotelData: data);
      //   },
      // ),
    );
  }
}
