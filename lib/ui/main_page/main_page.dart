import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/constants/user_constants.dart';
import 'package:room_finder_flutter/fragment/schedule_fragment.dart';
import 'package:room_finder_flutter/models/user/profile_response.dart';
import 'package:room_finder_flutter/ui/chat/chat_page.dart';
import 'package:room_finder_flutter/ui/guide/home/rf_home_tourguide_fragment.dart';
import 'package:room_finder_flutter/ui/guide/map/rf_map_page.dart';
import 'package:room_finder_flutter/ui/guide/warning_incident/warning_incident_page.dart';
import 'package:room_finder_flutter/ui/main_page/components/custom_circular_notched_rectangle.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../../fragment/discovery/discovery_fragment.dart';
import '../../provider/AuthProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> travelerPages = [
    const DiscoveryFragment(),
    ScheduleFragment(),
    const ChatPageScreen(),
  ];
  List<BottomNavigationBarItem> travelerItems = [
    BottomNavigationBarItem(
      icon: rf_search.iconImage(),
      label: 'Discovery',
      activeIcon: rf_search.iconImage(iconColor: rf_primaryColor),
    ),
    const BottomNavigationBarItem(
      icon: SizedBox.shrink(),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: rf_message.iconImage(),
      label: 'Chat',
      activeIcon: const Icon(Icons.message),
    ),
  ];

  List<Widget> tourGuidePages = [
    const RFHomeTourGuideFragment(),
    const DiscoveryFragment(),
    RFMapPage(),
    const WarningIncidentPage(),
    const ChatPageScreen(),
  ];
  List<BottomNavigationBarItem> tourGuideItems = [
    BottomNavigationBarItem(
      icon: rf_home.iconImage(),
      label: 'Home',
      activeIcon: rf_home.iconImage(iconColor: rf_primaryColor),
    ),
    BottomNavigationBarItem(
      icon: rf_search.iconImage(),
      label: 'Discovery',
      activeIcon: rf_search.iconImage(iconColor: rf_primaryColor),
    ),
    const BottomNavigationBarItem(
      icon: SizedBox.shrink(),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: rf_ticket.iconImage(size: 22),
      label: 'Ticket',
      activeIcon: rf_ticket.iconImage(iconColor: rf_primaryColor, size: 22),
    ),
    BottomNavigationBarItem(
      icon: rf_message.iconImage(),
      label: 'Inbox',
      activeIcon: const Icon(Icons.message),
    ),
  ]; //báo lỗi nếu mảng có ít hơn hoặc bằng 2 item

  Widget _bottomTab(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    List<BottomNavigationBarItem> items =
        authProvider.user.role == RoleStatus.Traveler ? travelerItems : tourGuideItems;

    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: CustomCircularNotchedRectangle(
            notchOffset: const Offset(-16, 0),
          ),
          notchMargin: 8.0,
          elevation: 0,
          child: Stack(
            children: [
              CupertinoTabBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                backgroundColor: Colors.white, // Set your desired background color
                activeColor: rf_primaryColor, // Set your desired active color
                inactiveColor: Colors.grey, // Set your desired inactive color
                border: null,
                items: items,
              ).paddingAll(8),
              StreamBuilder<bool>(
                stream: _userConstants.watchNotifyMess(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    bool isUnRead = snapshot.data!;
                    print("isUnRead $isUnRead");
                    if (isUnRead && _selectedIndex != 4) {
                      return Positioned(
                        right: 25,
                        top: 10,
                        child: Container(
                          width: 8, // Đặt chiều rộng của Container bằng đường kính của hình tròn
                          height: 8, // Đặt chiều cao của Container bằng đường kính của hình tròn
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      );
                    } else {
                      if (isUnRead) _userConstants.setNotifyMess(false);
                      return const SizedBox();
                    }
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ).paddingOnly(left: 16, right: 16),
    );
  }

  final _userConstants = GetIt.I.get<UserConstants>();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 4) _userConstants.setNotifyMess(false);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    List<Widget> pages =
        authProvider.user.role == RoleStatus.Traveler ? travelerPages : tourGuidePages;
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: _bottomTab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: whiteColor,
          child: SvgPicture.asset(
            shoe_prints,
            height: 18,
            color: rf_primaryColor,
          ),
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          }),
      body: IndexedStack(
          index: _selectedIndex,
          children:
              // [Center(child: _pages.elementAt(_selectedIndex))]
              pages),
    );
  }
}
