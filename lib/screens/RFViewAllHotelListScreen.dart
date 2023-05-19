import 'package:flutter/material.dart';
import 'package:room_finder_flutter/components/RFHotelListComponent.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../data/repositories/repositories.dart';
import '../models/tour/tour_detail_response.dart';
import '../models/tour/tour_list_response.dart';

class RFViewAllHotelListScreen extends StatefulWidget {
  const RFViewAllHotelListScreen({super.key});

  @override
  State<RFViewAllHotelListScreen> createState() =>
      _RFViewAllHotelListScreenState();
}

class _RFViewAllHotelListScreenState extends State<RFViewAllHotelListScreen> {
  Future<TourListResponse>? listTour;
  void getTourList() {
    listTour = AppRepository().getTourList();
  }

  @override
  void initState() {
    super.initState();
    getTourList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          commonAppBarWidget(context, title: 'App Bar', showLeadingIcon: false),
      body: FutureBuilder<TourListResponse>(
        future: listTour,
        builder:
            (BuildContext context, AsyncSnapshot<TourListResponse> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              // height: context.height() * 0.5,
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            final tours = snapshot.data!;
            return Center(
                // child: ListView.builder(
                //     itemCount: tours.values!.length,
                //     itemBuilder: (context, index) {
                //       print(tours.values![index].code);
                //       return Column(
                //         children: [
                //           RFHotelListComponent(
                //               tourListData: tours.values![index]),
                //         ],
                //       );
                //     })
                );
          }
        },
      ),

      // body: ListView.builder(
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
