import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/models/TourFinderModel.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFHotelDetailComponent extends StatelessWidget {
  final List<TourFinderModel> hotelImageData = hotelImageList();
  final TourFinderModel? hotelData;

  RFHotelDetailComponent({this.hotelData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              children: [
                // rfCommonCachedNetworkImage(rf_user,
                //         width: 60, height: 60, fit: BoxFit.cover)
                //     .cornerRadiusWithClipRRect(30),
                // 16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'DU LỊCH THỤY SĨ [ZURICH – LUCERNE – ISELTWALD – INTERLAKEN – GRINDELWALD - GRUYÈRES – ZERMATT – MATTERHORN - MONTREUX – LAUSANNE - GENEVA]',
                        style: boldTextStyle()),
                    4.height,
                    Text('Hồ Chí Minh', style: secondaryTextStyle()),
                  ],
                ).expand(),
                AppButton(
                  onTap: () {
                    launchCall("1234567890");
                  },
                  color: rf_primaryColor,
                  width: 15,
                  height: 15,
                  elevation: 0,
                  child: rf_call.iconImage(iconColor: white, size: 14),
                ),
                8.width,
                AppButton(
                  onTap: () {
                    launchMail("demo@gmail.com");
                  },
                  color: rf_primaryColor,
                  width: 15,
                  height: 15,
                  elevation: 0,
                  child: rf_message.iconImage(iconColor: white, size: 14),
                ),
              ],
            ),
            24.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: rf_primaryColor)
                    .paddingOnly(top: 2),
                16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1.2 km from Gwarko', style: boldTextStyle()),
                    8.height,
                    Text('Mahalaxmi, Lalitpur', style: primaryTextStyle()),
                    8.height,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('0 Applied',
                                style: boldTextStyle(
                                    color: appStore.isDarkModeOn
                                        ? white
                                        : rf_textColor))
                            .flexible(),
                        4.width,
                        Container(
                            height: 16, width: 1, color: context.iconColor),
                        4.width,
                        Text('19 Views',
                                style: boldTextStyle(
                                    color: appStore.isDarkModeOn
                                        ? white
                                        : rf_textColor))
                            .flexible(),
                      ],
                    )
                  ],
                ).expand(),
                16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   children: [
                    //     Container(
                    //       padding: EdgeInsets.all(4),
                    //       decoration: boxDecorationWithRoundedCorners(
                    //           backgroundColor: hotelData!.color!,
                    //           boxShape: BoxShape.circle),
                    //     ),
                    //     6.width,
                    //     Text(hotelData!.status.validate(),
                    //         style: secondaryTextStyle()),
                    //   ],
                    // ),
                    8.height,
                    Text(
                      'Code: MYQ0Q-2304',
                      style: primaryTextStyle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ).paddingOnly(left: 2),
                    8.height,
                    Text(
                      'View on Google Maps',
                      style: primaryTextStyle(
                          color: appStore.isDarkModeOn ? white : rf_textColor,
                          decoration: TextDecoration.underline),
                    ).paddingOnly(left: 2),
                  ],
                ).expand()
              ],
            ),
          ],
        ).paddingAll(24),
        HorizontalList(
          padding: EdgeInsets.only(right: 24, left: 24),
          wrapAlignment: WrapAlignment.spaceEvenly,
          itemCount: hotelImageData.length,
          itemBuilder: (_, int index) => Stack(
            alignment: Alignment.center,
            children: [
              rfCommonCachedNetworkImage(hotelImageData[index].img.validate(),
                  height: 70, width: 70, fit: BoxFit.cover),
              Container(
                height: 70,
                width: 70,
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: BorderRadius.circular(8),
                  backgroundColor: black.withOpacity(0.5),
                ),
              ),
              Text('+ 5',
                      style: boldTextStyle(color: white, size: 20),
                      textAlign: TextAlign.center)
                  .visible(index == 3),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description', style: boldTextStyle()),
            8.height,
            Text(
              '- Hành trình du ngoạn tại quốc gia đáng sống nhất thế giới Thụy Sỹ - thành phố Zurich nổi tiếng với nhiều khu phố đặc trưng của châu Âu, mang trong mình vẻ đẹp kiến trúc cổ kính, nghệ thuật trung cổ đầy màu sắc và mê hoặc.\n- Trải nghiệm quang cảnh tuyệt đẹp ở thiên đường nghỉ dưỡng lý tưởng của người Thụy Sĩ theo dấu chân bộ phim Hạ cánh nơi anh: thung lũng Grindelwald, hồ Brienz, thị trấn Interlaken - cửa ngõ thiên đường nằm giữa những hồ nước thơ mộng mang vẻ đẹp cổ tích.\n- Tham quan thị trấn cổ kính Lucerne bao quanh dãy núi Alps, bên cạnh cây cầu gỗ Chapel có từ thế kỷ 14 duyên dáng và đầy lãng mạn\n- Tận kiến đài phun nước Jet d"eau cao nhất thế giới tại Geneve và Lausanne - nơi có phong cảnh ngoạn mục và còn được mệnh danh là thành phố của những giấc mơ cổ tích.\n- Được trải nghiệm cáp treo cao nhất ở Châu Âu lên đỉnh Klien Matterhorn và chiêm ngưỡng cảnh quan tuyệt đẹp của vùng núi Alps hùng vĩ.',
              style: secondaryTextStyle(),
            ),
            24.height,
            Text('Facilities', style: boldTextStyle()),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.done, size: 20, color: rf_primaryColor),
                        8.width,
                        Text('Vé tham quan', style: secondaryTextStyle()),
                      ],
                    ),
                    4.height,
                    Row(
                      children: [
                        Icon(Icons.airplane_ticket,
                            size: 20, color: rf_primaryColor),
                        8.width,
                        Text('Bảo hiểm', style: secondaryTextStyle()),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.food_bank, size: 20, color: rf_primaryColor),
                        8.width,
                        Text('Bữa ăn', style: secondaryTextStyle()),
                      ],
                    ),
                    4.height,
                    Row(
                      children: [
                        Icon(Icons.bus_alert, size: 20, color: rf_primaryColor),
                        8.width,
                        Text('Xe đưa đón', style: secondaryTextStyle()),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ).paddingOnly(left: 24, right: 24, top: 24, bottom: 8),
      ],
    );
  }
}
