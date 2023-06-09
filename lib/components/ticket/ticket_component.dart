import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/repositories.dart';
import '../../models/tour/tour_detail_response.dart';
import '../../provider/AuthProvider.dart';
import '../../screens/ticket/ticket_detail_screen.dart';

class Ticket extends StatefulWidget {
  final double margin;
  final double borderRadius;
  final double clipRadius;
  final double smallClipRadius;
  final int numberOfSmallClips;
  final String tourId;

  const Ticket({
    Key? key,
    this.margin = 20,
    this.borderRadius = 10,
    this.clipRadius = 15,
    this.smallClipRadius = 5,
    this.numberOfSmallClips = 13,
    required this.tourId,
  }) : super(key: key);

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  late Future<TourDetailResponse> tour;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    getTourDetail(widget.tourId);
    print('Ticket component: ' + widget.tourId);
  }

  void getTourDetail(tourId) {
    authProvider = context.read<AuthProvider>();
    tour = AppRepository().getTourDetail(tourId);
    // print('Ticket component: ' + tour.then((value) => value.code).toString());
  }

  @override
  Widget build(BuildContext context) {
    final ticketWidth = context.width() - widget.margin * 2;
    final ticketHeight = ticketWidth * 0.5;

    return FutureBuilder<TourDetailResponse>(
        future: tour,
        builder:
            (BuildContext context, AsyncSnapshot<TourDetailResponse> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: context.height() * 0.5,
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            final t = snapshot.data!;
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
                  borderRadius: widget.borderRadius,
                  clipRadius: widget.clipRadius,
                  smallClipRadius: widget.smallClipRadius,
                  numberOfSmallClips: widget.numberOfSmallClips,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 25,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: Colors.green, width: 1)),
                                    child: Center(
                                      child: Text(
                                        'Upcoming',
                                        style: secondaryTextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text(
                                      t.title!,
                                      style: boldTextStyle(size: 12),
                                    ),
                                  ),
                                  Text(t.type!)
                                ],
                              ),
                            )),
                        Flexible(
                            flex: 55,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Material.Icon(
                                        Icons.schedule_outlined,
                                        size: 15,
                                      ),
                                      Text('Schedule',
                                          style: secondaryTextStyle()),
                                      // Text(
                                      //   '${DateFormat('dd/MM/yyyy').format(DateTime.parse(t.startTime!))} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(t.endTime!))}',
                                      // ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Material.Icon(
                                        Icons.place,
                                        size: 15,
                                      ),
                                      Text(
                                        'From - To',
                                        style: secondaryTextStyle(),
                                      ),
                                      Text('${t.departure} - ${t.destination}')
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
                tourDetail: t,
              ).launch(context);
            });
          }
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
