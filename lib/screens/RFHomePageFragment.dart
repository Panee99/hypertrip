import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:room_finder_flutter/screens/widget/popular_tour.dart';
import '../widget/categories_widget.dart';

class RFHomePageFragment extends StatelessWidget {
  // const RFHomePageFragment({super.key});
  List catNames = ["Food", "Coffee", "NightLife", "Fun", "Shopping"];
  List<SvgPicture> catIcons = [
    SvgPicture.asset(
      'assets/icons/pizza.svg',
    ),
    SvgPicture.asset(
      'assets/icons/coffee.svg',
    ),
    SvgPicture.asset(
      'assets/icons/nightlife.svg',
    ),
    SvgPicture.asset(
      'assets/icons/fun.svg',
    ),
    SvgPicture.asset(
      'assets/icons/shopping.svg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4FA),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 8, left: 30, right: 30, bottom: 8),
            decoration: BoxDecoration(
              color: Color(0xFF3E99C9),
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(20),
              //   bottomRight: Radius.circular(20),
              // ),
            ),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi Pannie',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_sharp,
                                color: Colors.black,
                                size: 12,
                              ),
                              Text('Ho Chi Minh City')
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.notifications,
                        size: 24,
                        color: Colors.black,
                      ),
                      // Icon(
                      //   Icons.account_circle,
                      //   size: 30,
                      //   color: Colors.white,
                      // ),
                    ]),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32, left: 30, right: 30, bottom: 8),
            child: Text(
              "Nearby you",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Container(
                height: 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: catNames.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              color: Color(0xFFD7E8F9),
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: catIcons[index]),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            catNames[index],
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 8,
              left: 30,
              right: 30,
              bottom: 8,
            ),
            child: Text(
              'Popular Tour',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          PopularTour(),
          // CategoriesWidget(),
        ],
      ),
    );
  }
}
