import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/bloc/tour/tour_detail_bloc.dart';
import 'package:room_finder_flutter/bloc/tour/tour_detail_event.dart';
import 'package:room_finder_flutter/bloc/tour/tour_detail_state.dart';
import 'package:room_finder_flutter/components/tour/photo_dialog_component.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'package:flutter/material.dart' as Material;

import '../../models/tour/tour_detail_response.dart';
import '../../utils/RFImages.dart';

class TourDetailScreen extends StatefulWidget {
  final String tourId;

  TourDetailScreen({required this.tourId});

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  late LoadTourDetailEvent loadTourDetailEvent;
  late TourDetailBloc tourDetailBloc;
  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    authProvider = context.read<AuthProvider>();
    loadTourDetailEvent =
        LoadTourDetailEvent(widget.tourId, authProvider.token);
    tourDetailBloc.add(loadTourDetailEvent);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    tourDetailBloc.close();
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RepositoryProvider(
      create: (context) => AppRepository(),
      child: BlocProvider(
        create: (context) =>
            TourDetailBloc(RepositoryProvider.of<AppRepository>(context))
              ..add(LoadTourDetailEvent(widget.tourId, authProvider.token)),
        child: BlocBuilder<TourDetailBloc, TourDetailState>(
            builder: (context, state) {
          if (state is TourDetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TourDetailLoadedState) {
            var tourDetail = state.tourDetail;
            List<Schedules> sortedSchedules = tourDetail.schedules!.toList()
              ..sort((a, b) => a.sequence!.compareTo(b.sequence as num));
            return Scaffold(
                // bottomNavigationBar: AppButton(
                //   color: rf_primaryColor,
                //   elevation: 0,
                //   child: Text('Booking', style: boldTextStyle(color: white)),
                //   width: context.width(),
                //   height: 36,
                //   onTap: () {
                //     BookingScreen(tour: tourDetail).launch(context);
                //   },
                // ).paddingSymmetric(horizontal: 16, vertical: 24),
                body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                      icon: Material.Icon(Icons.arrow_back_ios_new,
                          color: blackColor, size: 18),
                      onPressed: () {
                        finish(context);
                      },
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16)),
                    ),
                    backgroundColor: whiteColor,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: whiteColor,
                        statusBarIconBrightness: Brightness.dark),
                    pinned: true,
                    elevation: 2,
                    expandedHeight: 260,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      background: Stack(
                        children: [
                          rfCommonCachedNetworkImage(
                            tourDetail.thumbnailUrl.validate(),
                            fit: BoxFit.cover,
                            width: context.width(),
                            height: 288,
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // rfCommonCachedNetworkImage(rf_user,
                        //         width: 60, height: 60, fit: BoxFit.cover)
                        //     .cornerRadiusWithClipRRect(30),
                        // 16.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${tourDetail.title.validate()}',
                                style: boldTextStyle()),
                            // 4.height,
                            // Text('Landlord', style: secondaryTextStyle()),
                          ],
                        ).expand(),
                        32.width,
                        AppButton(
                          onTap: () {
                            // launchMail("demo@gmail.com");
                          },
                          color: rf_primaryColor,
                          width: 10,
                          height: 10,
                          elevation: 0,
                          child:
                              rf_message.iconImage(iconColor: white, size: 20),
                        ),
                      ],
                    ).paddingAll(16),
                    HorizontalList(
                      padding: EdgeInsets.only(right: 24),
                      wrapAlignment: WrapAlignment.spaceEvenly,
                      itemCount: tourDetail.carousel!.length,
                      itemBuilder: (_, int index) => Stack(
                        alignment: Alignment.center,
                        children: [
                          rfCommonCachedNetworkImage(
                                  '${tourDetail.carousel![index].url.validate()}',
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover)
                              .onTap(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => PhotoDialog(
                                      carousel: tourDetail.carousel.validate(),
                                      currentCarouselIndex: index,
                                    ));
                            setState(() {});
                          }),
                        ],
                      ),
                    ).paddingOnly(left: 16, top: 16, bottom: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Schedule', style: boldTextStyle()),
                        6.height,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: whiteColor),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: sortedSchedules.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFEE766E),
                                              shape: BoxShape.circle),
                                        ),
                                        8.width,
                                        Flexible(
                                          child: Text(
                                            sortedSchedules[index]
                                                .description
                                                .validate(),
                                            overflow: TextOverflow.visible,
                                            style: secondaryTextStyle(),
                                          ),
                                        )
                                      ],
                                    ).paddingBottom(
                                        index == sortedSchedules.length - 1
                                            ? 0
                                            : 8);
                                  },
                                )
                              ]).paddingAll(8),
                        ),
                      ],
                    ).paddingAll(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description', style: boldTextStyle()),
                        8.height,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: whiteColor),
                          child: Flexible(
                              child: Text(
                            tourDetail.description.validate(),
                            style: secondaryTextStyle(),
                            overflow: TextOverflow.visible,
                          )).paddingAll(8),
                        )
                      ],
                    ).paddingAll(16),
                  ],
                ),
              ),
            ));
          } else {
            return SizedBox.shrink();
          }
        }),
      ),
    ));
  }
}
