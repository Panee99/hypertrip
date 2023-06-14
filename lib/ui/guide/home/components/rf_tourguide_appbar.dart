import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/bloc/location/location_bloc.dart';
import 'package:room_finder_flutter/bloc/location/location_event.dart';
import 'package:room_finder_flutter/bloc/location/location_state.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/routers.dart';
import 'package:room_finder_flutter/ui/guide/home/components/rf_avatar.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/app_languages.dart';

class RFTourGuideAppbar extends StatelessWidget with PreferredSizeWidget {
  const RFTourGuideAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return AppBar(
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$rf_lang_hi${authProvider.user.firstName.validate()} ${authProvider.user.lastName.validate()}',
                style: boldTextStyle(color: textBlurColor, size: 12),
              ),
              RepositoryProvider(
                create: (context) => GoogleRepository(),
                child: BlocProvider(
                  create: (context) =>
                      LocationBloc(RepositoryProvider.of<GoogleRepository>(context))
                        ..add(const LoadLocationEvent()),
                  child: BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
                    if (state is LocationLoadingState) {
                      return const SizedBox.shrink();
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
                      return const SizedBox.shrink();
                    }
                  }),
                ),
              )
            ]).paddingLeft(16),
        leadingWidth: 150,
        elevation: 0,
        backgroundColor: whiteSmoke,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: whiteSmoke,
          statusBarIconBrightness: Brightness.dark,
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(Routers.NOTIFICATION),
                  child: SvgPicture.asset(notification, height: 20)),
              16.width,
              const RFAvatar(),
            ],
          ).paddingRight(16),
        ]);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(40);
}
