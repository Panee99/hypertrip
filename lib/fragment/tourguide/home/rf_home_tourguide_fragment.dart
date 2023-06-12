import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/bloc/location/location_bloc.dart';
import 'package:room_finder_flutter/bloc/location/location_event.dart';
import 'package:room_finder_flutter/bloc/location/location_state.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/fragment/tourguide/home/components/rf_avatar.dart';
import 'package:room_finder_flutter/fragment/tourguide/home/components/rf_category.dart';
import 'package:room_finder_flutter/fragment/tourguide/home/components/rf_current_tour.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/app_languages.dart';

class RFHomeTourGuideFragment extends StatelessWidget {
  const RFHomeTourGuideFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rf_lang_hi +
                        authProvider.user.firstName.validate() +
                        ' ' +
                        authProvider.user.lastName.validate(),
                    style: boldTextStyle(color: textBlurColor, size: 12),
                  ),
                  RepositoryProvider(
                    create: (context) => GoogleRepository(),
                    child: BlocProvider(
                      create: (context) =>
                          LocationBloc(RepositoryProvider.of<GoogleRepository>(context))
                            ..add(LoadLocationEvent()),
                      child: BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
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
              statusBarIconBrightness: Brightness.dark,
            ),
            actions: [
              Row(
                children: [
                  SvgPicture.asset(notification, height: 20),
                  16.width,
                  RFAvatar(),
                ],
              ).paddingRight(16),
            ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RFCategory(),
          RFCurrentTour(),
        ],
      ).paddingOnly(left: 16, top: 32),
    );
  }
}
