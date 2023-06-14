import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
// import 'package:room_finder_flutter/fragment/RFHomeTourGuideFragment.dart';
import 'package:room_finder_flutter/fragment/inbox_fragment.dart';
import 'package:room_finder_flutter/fragment/schedule_fragment.dart';
import 'package:room_finder_flutter/fragment/tourguide/home/rf_home_tourguide_fragment.dart';
import 'package:room_finder_flutter/fragment/tourguide/map/rf_map_page.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/warning_incident_page.dart';
import 'package:room_finder_flutter/models/user/profile_response.dart';
import 'package:room_finder_flutter/screens/chat/chat_page.dart';
import 'package:room_finder_flutter/screens/main_page/components/custom_circular_notched_rectangle.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';
import 'dart:math' as math;

import '../../fragment/discovery/discovery_fragment.dart';
import '../../provider/AuthProvider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> travelerPages = [
    const DiscoveryFragment(),
    ScheduleFragment(),
    // InboxFragment(),
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
        authProvider.user.role == RoleStatus.Traveler
            ? travelerItems
            : tourGuideItems;

    if (Theme.of(context).platform == TargetPlatform.android) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: CustomCircularNotchedRectangle(
            notchOffset: const Offset(-16, 0),
          ),
          notchMargin: 8.0,
          elevation: 0,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedLabelStyle: boldTextStyle(size: 14, color: rf_primaryColor),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: items,
          ),
        ),
      ).paddingOnly(left: 16, right: 16, top: 16);
    } else {
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
            child: CupertinoTabBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor:
                  Colors.white, // Set your desired background color
              activeColor: rf_primaryColor, // Set your desired active color
              inactiveColor: Colors.grey, // Set your desired inactive color
              border: null,
              items: items,
            ).paddingAll(8),
          ),
        ).paddingOnly(left: 16, right: 16),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(rf_primaryColor,
        statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    List<Widget> pages =
        authProvider.user.role == 'Traveler' ? travelerPages : tourGuidePages;
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
