import 'package:flutter/material.dart' as Material;
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/map/nearby_response.dart';
import 'package:room_finder_flutter/models/map/place_photo_response.dart';
import 'package:room_finder_flutter/screens/place_details_screen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import '../utils/network.dart';

class PlaceListComponent extends Material.StatefulWidget {
  final Results placeNearby;
  final bool? showHeight;
  final int photoIndex;

  PlaceListComponent(
      {required this.placeNearby, this.showHeight, required this.photoIndex});

  @override
  Material.State<PlaceListComponent> createState() =>
      _PlaceListComponentState();
}

class _PlaceListComponentState extends Material.State<PlaceListComponent> {
  late Future<List<PlacesPhotoResponse>> photosList;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    try {
      photosList =
          GetPhotoByID.getPlacePhoto(widget.placeNearby.fsqId.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlacesPhotoResponse>>(
        future: photosList,
        builder: (BuildContext context,
            AsyncSnapshot<List<PlacesPhotoResponse>> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: context.height() * 0.5,
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            final photos = snapshot.data!;
            return Container(
                width: context.width(),
                decoration: boxDecorationRoundedWithShadow(8,
                    backgroundColor: context.cardColor),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(bottom: 16),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rfCommonCachedNetworkImage(
                              photos.isNotEmpty
                                  ? '${photos[widget.photoIndex].prefix}100x100${photos[widget.photoIndex].suffix}'
                                  : placeholder,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(8),
                      16.width,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.placeNearby.name!,
                                      style: boldTextStyle()),
                                  8.height,
                                  Text(
                                      widget.placeNearby.categories!.first.name
                                          .toString(),
                                      style: secondaryTextStyle()),
                                ],
                              ).expand(),
                            ],
                          ).paddingOnly(left: 3),
                          widget.showHeight.validate() ? 8.height : 24.height,
                          Row(
                            children: [
                              Material.Icon(Icons.location_on,
                                  color: rf_primaryColor, size: 16),
                              6.width,
                              Flexible(
                                child: Text(
                                  widget.placeNearby.location!.address != null
                                      ? widget.placeNearby.location!.address
                                          .toString()
                                      : widget.placeNearby.location!.locality
                                          .toString(),
                                  style: secondaryTextStyle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).expand()
                    ])).onTap(() {
              PlaceDetailsScreen(
                photos: photos,
                place: widget.placeNearby,
              ).launch(context);
            });
          }
        });
  }
}
