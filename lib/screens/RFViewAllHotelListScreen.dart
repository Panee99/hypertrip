import 'package:flutter/material.dart';
import 'package:room_finder_flutter/components/RFHotelListComponent.dart';
import 'package:room_finder_flutter/models/RoomFinderModel.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFViewAllHotelListScreen extends StatelessWidget {
  final List<RoomFinderModel> hotelListData = hotelList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
      appBar: commonAppBarWidget(context,
          title: "Tour List",
          appBarHeight: 80,
          showLeadingIcon: false,
          roundCornerShape: true),
      body: ListView.builder(
        padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 24),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          RoomFinderModel data = hotelListData[index % hotelListData.length];
          return RFHotelListComponent(hotelData: data);
=======
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
                child: ListView.builder(
                    itemCount: tours.values!.length,
                    itemBuilder: (context, index) {
                      print(tours.values![index].code);
                      return Column(
                        children: [
                          RFHotelListComponent(
                              tourListData: tours.values![index]),
                        ],
                      );
                    }));
          }
>>>>>>> Stashed changes
        },
      ),
    );
  }
}
