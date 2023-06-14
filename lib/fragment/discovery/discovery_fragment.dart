import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/components/RFCommonAppComponent.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../bloc/location/location_bloc.dart';
import '../../bloc/location/location_event.dart';
import '../../bloc/location/location_state.dart';
import '../../bloc/nearby/nearby_bloc.dart';
import '../../bloc/nearby/nearby_event.dart';
import '../../bloc/nearby/nearby_state.dart';
import '../../components/discovery/map_dialog_component.dart';
import '../../components/discovery/nearby_places_component.dart';
import '../../components/discovery/search_place/search_place_component.dart';
import '../../data/repositories/repositories.dart';
import '../../models/discovery/nearby_response.dart';
import '../../provider/AuthProvider.dart';
import '../../utils/RFColors.dart';
import '../../utils/RFImages.dart';
import '../../utils/RFWidget.dart';

class DiscoveryFragment extends StatefulWidget {
  const DiscoveryFragment({super.key});

  @override
  State<DiscoveryFragment> createState() => _MapFragmentState();
}

class _MapFragmentState extends State<DiscoveryFragment> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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

  TextEditingController place = TextEditingController();

  FocusNode placeFocusNode = FocusNode();

  String cate = '';

  late LatLng latLngPosition = LatLng(0, 0);

  bool isSearch = false;

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latLngPosition = LatLng(position.latitude, position.longitude);
    });

    // Move camera to the current location
    // mapController.animateCamera(CameraUpdate.newLatLngZoom(latLngPosition, 2.0));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return BlocProvider(
        create: (context) =>
            PlaceBloc(RepositoryProvider.of<FoursquareRepository>(context))
              ..add(LoadPlaceEvent()),
        child: Scaffold(
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
                                RepositoryProvider.of<GoogleRepository>(
                                    context))
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
                          backgroundImage:
                              authProvider.user.avatarUrl.validate() != ''
                                  ? NetworkImage(authProvider.user.avatarUrl
                                      .validate()) as ImageProvider<Object>?
                                  : AssetImage(avatar_placeholoder),
                        ),
                      ],
                    ).paddingRight(16),
                  ]),
            ),
            body:
                // RFCommonAppComponent(
                //   scroll: true,
                //   // title: RFAppName,
                //   mainWidgetHeight: screenHeight * 0.2,
                //   subWidgetHeight: screenHeight * 0.1,
                //   cardWidget: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       // Text('Tìm Kiếm', style: boldTextStyle(size: 18)),
                //       // 16.height,
                //       AppTextField(
                //         controller: place,
                //         focus: placeFocusNode,
                //         textFieldType: TextFieldType.NAME,
                //         decoration: rfInputDecoration(
                //           lableText: "What do you need...",
                //           showLableText: true,
                //           showPreFixIcon: true,
                //           prefixIcon: Material.Icon(Icons.search,
                //               color: rf_primaryColor, size: 16),
                //         ),
                //         onChanged: (value) {
                //           setState(() {
                //             searchQuery = value;
                //           });
                //         },
                //       ),
                //       16.height,
                //       Row(
                //         children: [
                //           Expanded(
                //             child: AppButton(
                //               color: rf_primaryColor,
                //               child:
                //                   Text('Find', style: boldTextStyle(color: white)),
                //               elevation: 0,
                //               onTap: searchQuery != ''
                //                   ? () {
                //                       setState(() {
                //                         isSearch = true;
                //                       });
                //                     }
                //                   : () {},
                //             ),
                //           ),
                //           16.width,
                //           AppButton(
                //             color: rf_primaryColor,
                //             child: Material.Icon(
                //               Icons.near_me,
                //               color: white,
                //             ),
                //             elevation: 0,
                //             width: 30,
                //             onTap: () {
                //               setState(() {
                //                 isSearch = false;
                //               });
                //             },
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                //   subWidget:
                SafeArea(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          search,
                          width: 16,
                          color: secondaryColor,
                        ),
                        16.width,
                        Text(
                          'Search for a place',
                          style:
                              primaryTextStyle(color: textBlurColor, size: 16),
                        )
                      ],
                    ).paddingAll(16),
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
                            itemCount: catNames.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width:
                                    (MediaQuery.of(context).size.width - 32) /
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
                                      setState(() {
                                        cate = catNames[index];
                                      });
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
                  !isSearch
                      ? Container(
                          width: context.width(),
                          // padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text('Nearby you',
                                      style: boldTextStyle())),
                            ],
                          ),
                        )
                      : Container(
                          width: context.width(),
                          // padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text('Search results',
                                      style: boldTextStyle())),
                            ],
                          ),
                        ),
                  isSearch && searchQuery != ''
                      ? SearchPlaceComponent(query: searchQuery)
                      : NearbyPlacesComponent(
                          category: cate,
                        ),
                ],
              ).paddingSymmetric(horizontal: 16),
            ),
            floatingActionButton: !isSearch
                ? BlocBuilder<PlaceBloc, PlaceState>(builder: (context, state) {
                    if (state is PlaceLoadedState) {
                      NearbyPlacesResponse places = state.places;

                      return FloatingActionButton(
                        backgroundColor: rf_primaryColor,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => MapDialog(
                                    category: cate,
                                    places: places,
                                    lat: latLngPosition.latitude,
                                    lng: latLngPosition.longitude,
                                    nearby: true,
                                  ));
                          setState(() {});
                        },
                        child: Material.Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  })
                : null));
  }
}
