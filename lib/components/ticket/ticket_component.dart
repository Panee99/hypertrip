import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;
import 'package:nb_utils/nb_utils.dart';
import '../../screens/ticket/ticket_detail_screen.dart';

class Ticket extends StatelessWidget {
  final double margin;
  final double borderRadius;
  final double clipRadius;
  final double smallClipRadius;
  final int numberOfSmallClips;
  final String title, type, start, end, from, to, price;

  const Ticket({
    Key? key,
    this.margin = 20,
    this.borderRadius = 10,
    this.clipRadius = 15,
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
    final ticketWidth = context.width() - margin * 2;
    final ticketHeight = ticketWidth * 0.5;

    return Container(
      width: ticketWidth,
      height: ticketHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 20),
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipPath(
        clipper: TicketClipper(
          borderRadius: borderRadius,
          clipRadius: clipRadius,
          smallClipRadius: smallClipRadius,
          numberOfSmallClips: numberOfSmallClips,
        ),
        child: Container(
          color: Colors.white,
          child: Center(
            child: Row(
              children: [
                Flexible(
                    flex: 35,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 25,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: Colors.green, width: 1)),
                            child: Center(
                              child: Text(
                                'Upcoming',
                                style: secondaryTextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            title,
                            style: boldTextStyle(),
                          ),
                          Text(type)
                        ],
                      ),
                    )),
                Flexible(
                    flex: 55,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Material.Icon(
                                Icons.schedule_outlined,
                                size: 15,
                              ),
                              Text('Schedule', style: secondaryTextStyle()),
                              Text(
                                '${start} - ${end}',
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Material.Icon(
                                Icons.place,
                                size: 15,
                              ),
                              Text(
                                'From - To',
                                style: secondaryTextStyle(),
                              ),
                              Text('${from} - ${to}')
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    ).onTap(() {
      TicketDetailScreen(
              title: title,
              type: type,
              to: to,
              from: from,
              start: start,
              end: end,
              price: price)
          .launch(context);
    });
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

    final clipCenterX = size.width * 0.35 + clipRadius!;

    // draw rect
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius!),
    ));

    final clipPath = Path();

    // circle on the left
    clipPath.addOval(Rect.fromCircle(
      center: Offset(clipCenterX, 0),
      radius: clipRadius!,
    ));

    // circle on the right
    clipPath.addOval(Rect.fromCircle(
      center: Offset(clipCenterX, size.height),
      radius: clipRadius!,
    ));

// add dashed line
    final double dashWidth = 2;
    final double dashHeight = 4;
    final double dashSpacing =
        (size.height - 2 * clipRadius! - dashHeight * numberOfSmallClips!) /
            (numberOfSmallClips! - 1);
    final double startY = clipRadius! + dashSpacing;
    final double endY = size.height - clipRadius!;
    for (int i = 0; i < numberOfSmallClips!; i++) {
      final double startX = size.width * 0.35 + clipRadius!;
      final double endX = startX + dashWidth;
      final double y = startY + (dashHeight + dashSpacing) * i;
      clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(startX, y, dashWidth, dashHeight),
        Radius.circular(smallClipRadius!),
      ));
    }

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
