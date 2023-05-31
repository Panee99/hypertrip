import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/bloc/location/location_bloc.dart';
import 'package:room_finder_flutter/bloc/location/location_state.dart';
import 'package:room_finder_flutter/bloc/nearby/nearby_bloc.dart';
import 'package:room_finder_flutter/bloc/nearby/nearby_event.dart';
import 'package:room_finder_flutter/bloc/tour/tour_detail_event.dart';
import 'package:room_finder_flutter/fragment/discovery/discovery_fragment.dart';
import 'package:room_finder_flutter/screens/home/nearby_you.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFDataGenerator.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:flutter/material.dart' as Material;
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../bloc/location/location_event.dart';
import '../bloc/tour/tour_detail_bloc.dart';
import '../bloc/tour/tour_detail_state.dart';
import '../components/tour/popular_tour_component.dart';
import '../data/repositories/repositories.dart';
import '../provider/AuthProvider.dart';

class RFHomeFragment extends StatelessWidget {
  // const RFHomeFragment({super.key});
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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    List<Widget> travelBody = [
      Row(
        children: [
          Expanded(
            //     child: ElevatedButton(
            //   child: Text(
            //     'Booking Now',
            //     style: boldTextStyle(color: whiteColor),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //       primary: rf_primaryColor, elevation: 0),

            //   onPressed: () {},
            // )
            child: AppButton(
              color: rf_primaryColor,
              child: Text(
                'Booking Now',
                style: boldTextStyle(color: whiteColor),
              ),
              elevation: 0,
              width: 30,
              onTap: () {},
            ),
          ),
        ],
      ).paddingRight(16),
      32.height,
      Container(
        child: Text(
          "Nearby you",
          style: boldTextStyle(size: 12),
        ),
      ),
      SizedBox(
        height: 16,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 100,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: catNames.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: (MediaQuery.of(context).size.width - 32) /
                        catNames.length,
                    child: Column(
                      children: [
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color: Color(0xFFD7E8F9),
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: catIcons[index]),
                        ).onTap(() {
                          NearbyYou(
                            category: catNames[index],
                          ).launch(context);
                        }),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Text(
                          catNames[index],
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ).paddingRight(16),
                  );
                }),
          ),
        ],
      ),
      Container(
        child: Text(
          'Popular Tour',
          style: boldTextStyle(size: 12),
        ),
      ),
      16.height,
      RepositoryProvider(
        create: (context) => AppRepository(),
        child: BlocProvider(
          create: (context) =>
              TourListBloc(RepositoryProvider.of<AppRepository>(context))
                ..add(LoadTourListEvent()),
          child: BlocBuilder<TourListBloc, TourListState>(
            builder: (context, state) {
              if (state is TourListLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TourListLoadedState) {
                var tourList = state.tourList;
                return SingleChildScrollView(
                  // Wrap with SingleChildScrollView
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(tourList.values!.length, (index) {
                      return PopularTourComponent(
                        tour: tourList.values![index],
                      );
                    }),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
      // CategoriesWidget(),
    ];
    List<Widget> tourGuideBody = [];
    List<Widget> body = authProvider.user.role.toString() == 'Traveler'
        ? travelBody
        : tourGuideBody;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi ' +
                        authProvider.user.firstName.validate() +
                        ' ' +
                        authProvider.user.lastName.validate(),
                    style: boldTextStyle(color: textBlurColor, size: 12),
                  ),
                  RepositoryProvider(
                    create: (context) => GoogleRepository(),
                    child: BlocProvider(
                      create: (context) => LocationBloc(
                          RepositoryProvider.of<GoogleRepository>(context))
                        ..add(LoadLocationEvent()),
                      child: BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, state) {
                        if (state is LocationLoadingState) {
                          return SizedBox.shrink();
                        } else if (state is LocationLoadedState) {
                          var city = state.location;
                          return Row(
                            children: [
                              SizedBox(
                                child: SvgPicture.asset(
                                  location,
                                  height: 15,
                                  color: rf_primaryColor,
                                ),
                              ),
                              8.width,
                              Text(
                                city,
                                style: boldTextStyle(size: 12),
                              )
                            ],
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                    ),
                  )
                ]).paddingLeft(16),
            leadingWidth: 150,
            elevation: 0,
            backgroundColor: whiteSmoke,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: whiteSmoke,
                statusBarIconBrightness: Brightness.dark),
            actions: [
              Row(
                children: [
                  SvgPicture.asset(notification, height: 20),
                  16.width,
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: authProvider.user.avatarUrl.validate() !=
                            ''
                        ? NetworkImage(authProvider.user.avatarUrl.validate())
                            as ImageProvider<Object>?
                        : AssetImage(avatar_placeholoder),
                  ),
                ],
              ).paddingRight(16),
            ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: body,
      ).paddingOnly(left: 16, top: 32),
    );
  }
}
