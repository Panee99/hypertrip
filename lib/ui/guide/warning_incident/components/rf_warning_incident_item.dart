import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/incidents/weather_response.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class WeatherIncidentItem extends StatefulWidget {
  final WeatherResponse data;

  const WeatherIncidentItem({Key? key, required this.data}) : super(key: key);

  @override
  State<WeatherIncidentItem> createState() => _WeatherIncidentItemState();
}

class _WeatherIncidentItemState extends State<WeatherIncidentItem> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        isShow = !isShow;
      }),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: EdgeInsets.all(10),
        child: isShow
            ? AnimatedScrollView(reverse: true, children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: rfCommonCachedNetworkImage(
                            widget.data.current?.condition?.icon != null
                                ? 'https:${widget.data.current?.condition?.icon}'
                                : null),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.location?.country ?? '',
                          style: boldTextStyle(size: 18),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: widget.data.location?.name ?? '',
                                style: boldTextStyle(size: 16)),
                            TextSpan(
                                text: ' ${widget.data.current?.tempC.toInt()}°',
                                style: primaryTextStyle(size: 16))
                          ]),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: widget.data.current?.condition?.text ?? '',
                                style: primaryTextStyle(size: 16)),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(avatar_placeholoder),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The Pink Beach",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                location,
                                width: 11,
                                height: 11,
                                color: rf_primaryColor,
                              ),
                              5.width,
                              Text(
                                "Komodo Island, Indonesia",
                                style: TextStyle(color: rf_primaryColor),
                              ),
                            ],
                          ),
                          Text(
                            "This exceptional beach gets its striking color from microscopic animals called...",
                            // style: context.appTextTheme.bodyMedium,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '\$48',
                                style: TextStyle(
                                  color: color_primary_black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                            TextSpan(text: '/Person', style: TextStyle(color: rf_faqBgColor)),
                          ]))
                        ],
                      ),
                    ),
                  ],
                ),
              ])
            : Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: rfCommonCachedNetworkImage(widget.data.current?.condition?.icon != null
                          ? 'https:${widget.data.current?.condition?.icon}'
                          : null),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.location?.country ?? '',
                        style: boldTextStyle(size: 18),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: widget.data.location?.name ?? '',
                              style: boldTextStyle(size: 16)),
                          TextSpan(
                              text: ' ${widget.data.current?.tempC.toInt()}°',
                              style: primaryTextStyle(size: 16))
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: widget.data.current?.condition?.text ?? '',
                              style: primaryTextStyle(size: 16)),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}