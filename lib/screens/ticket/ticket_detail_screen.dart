import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/commons/colors.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

class TicketDetailScreen extends StatelessWidget {
  final double margin;
  final double borderRadius;
  final double clipRadius;
  final double smallClipRadius;
  final int numberOfSmallClips;
  final String title, type, start, end, from, to;
  final double price;

  const TicketDetailScreen({
    Key? key,
    this.margin = 20,
    this.borderRadius = 20,
    this.clipRadius = 20,
    this.smallClipRadius = 5,
    this.numberOfSmallClips = 13,
    required this.title,
    required this.type,
    required this.start,
    required this.end,
    required this.from,
    required this.to,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final ticketWidth = screenSize.width * 0.9;
    final ticketHeight = ticketWidth * 1.5;
    return Scaffold(
      backgroundColor: rf_faqBgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Material.Icon(Icons.arrow_back_ios_new, color: white, size: 18),
          onPressed: () {
            finish(context);
          },
        ),
        backgroundColor: rf_primaryColor,
      ),
      body: Center(
        child: Container(
          width: ticketWidth,
          height: ticketHeight,
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       offset: Offset(0, 20),
          //       color: Colors.black.withOpacity(0.2),
          //       blurRadius: 15,
          //       spreadRadius: 1,
          //     ),
          //   ],
          // ),
          child: ClipPath(
            clipper: TicketClipper(
              borderRadius: borderRadius,
              clipRadius: clipRadius,
              smallClipRadius: smallClipRadius,
              numberOfSmallClips: numberOfSmallClips,
            ),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.green, width: 2)),
                        child: Center(
                          child: Text(
                            'Upcoming',
                            style: primaryTextStyle(
                                color: Colors.green, weight: FontWeight.w900),
                          ),
                        ),
                      ),
                      20.height,
                      Text(
                        'Tour Ticket',
                        style:
                            primaryTextStyle(size: 23, weight: FontWeight.bold),
                      ),
                      20.height,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: secondaryTextStyle(),
                          ),
                          Text(
                            title,
                            style: primaryTextStyle(),
                          )
                        ],
                      ),
                      10.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Type',
                                      style: secondaryTextStyle(),
                                    ),
                                    Text(
                                      type,
                                      style: primaryTextStyle(),
                                    )
                                  ],
                                ),
                                10.height,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start',
                                      style: secondaryTextStyle(),
                                    ),
                                    Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(DateTime.parse(start)),
                                      style: primaryTextStyle(),
                                    )
                                  ],
                                ),
                                10.height,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'From',
                                      style: secondaryTextStyle(),
                                    ),
                                    Text(
                                      from,
                                      style: primaryTextStyle(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Price',
                                          style: secondaryTextStyle()),
                                      Text(
                                        '${price} \$',
                                        style: primaryTextStyle(
                                            weight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  10.height,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'End',
                                        style: secondaryTextStyle(),
                                      ),
                                      Text(
                                        DateFormat('dd/MM/yyyy')
                                            .format(DateTime.parse(end)),
                                        style: primaryTextStyle(),
                                      )
                                    ],
                                  ),
                                  10.height,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'To',
                                        style: secondaryTextStyle(),
                                      ),
                                      Text(
                                        to,
                                        style: primaryTextStyle(),
                                      )
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                      20.height,
                      Center(
                        child: Image.asset(
                          'assets/images/qr.png',
                          width: 150,
                          height: 150,
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  static const double clipPadding = 18;

  final double? borderRadius;
  final double? clipRadius;
  final double? smallClipRadius;
  final int? numberOfSmallClips;

  const TicketClipper({
    this.borderRadius,
    this.clipRadius,
    this.smallClipRadius,
    this.numberOfSmallClips,
  });

  @override
  Path getClip(Size size) {
    var path = Path();

    final clipCenterY = size.height * 0.5;

    // draw rect
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius!),
    ));

    final clipPath = Path();

    // circle on the left
    clipPath.addOval(Rect.fromCircle(
      center: Offset(0, clipCenterY),
      radius: clipRadius!,
    ));

    // circle on the right
    clipPath.addOval(Rect.fromCircle(
      center: Offset(size.width, clipCenterY),
      radius: clipRadius!,
    ));

    // combine two path together
    final ticketPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      path,
    );

    return ticketPath;
  }

  @override
  bool shouldReclip(TicketClipper old) =>
      old.borderRadius != borderRadius ||
      old.clipRadius != clipRadius ||
      old.smallClipRadius != smallClipRadius ||
      old.numberOfSmallClips != numberOfSmallClips;
}
