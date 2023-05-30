import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class PhotoDialog extends StatefulWidget {
  final List<Carousel> carousel;
  final int currentCarouselIndex;
  const PhotoDialog(
      {super.key, required this.carousel, required this.currentCarouselIndex});

  @override
  State<PhotoDialog> createState() => _PhotoDialogState();
}

class _PhotoDialogState extends State<PhotoDialog> {
  @override
  Widget build(BuildContext context) {
    return
        // Dialog(
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        //   child: Container(
        //     child: rfCommonCachedNetworkImage(widget.url, fit: BoxFit.cover),
        //   ),
        // );
        Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          rfCommonCachedNetworkImage(
              widget.carousel[widget.currentCarouselIndex].url,
              fit: BoxFit.cover),
          Positioned(
            right: 0,
            left: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: SvgPicture.asset(
                  angle_left,
                  height: 24,
                  color: whiteColor,
                ),
                onPressed: widget.currentCarouselIndex > 0
                    ? () {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) => PhotoDialog(
                            carousel: widget.carousel,
                            currentCarouselIndex:
                                widget.currentCarouselIndex - 1,
                          ),
                        );
                      }
                    : null,
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: SvgPicture.asset(
                  angle_right,
                  height: 24,
                  color: whiteColor,
                ),
                onPressed:
                    widget.currentCarouselIndex < widget.carousel.length - 1
                        ? () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) => PhotoDialog(
                                carousel: widget.carousel,
                                currentCarouselIndex:
                                    widget.currentCarouselIndex + 1,
                              ),
                            );
                          }
                        : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
