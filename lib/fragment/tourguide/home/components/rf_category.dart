import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/data_demo.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/app_languages.dart';

class RFCategory extends StatelessWidget {
  const RFCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            rf_lang_nearByYou,
            style: boldTextStyle(size: 12),
          ),
        ),
        16.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: (MediaQuery.of(context).size.width - 32) / categories.length,
                      child: Column(
                        children: [
                          Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              color: rf_splashBgColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: SvgPicture.asset(categories[index].img)),
                          ),
                          Text(
                            categories[index].catName,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ).paddingRight(16),
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
