import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/fragment/schedule_fragment.dart';
import 'package:room_finder_flutter/fragment/tourguide/home/rf_home_tourguide_fragment.dart';
import 'package:room_finder_flutter/fragment/tourguide/map/rf_map_page.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/warning_incident_page.dart';
import 'package:room_finder_flutter/screens/chat/chat_page.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../fragment/discovery/discovery_fragment.dart';
import '../provider/AuthProvider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> travelerPages = [
    DiscoveryFragment(),
    ScheduleFragment(),
    // InboxFragment(),
    ChatPageScreen(),
  ];
  List<BottomNavigationBarItem> travelerItems = [
    BottomNavigationBarItem(
      icon: rf_search.iconImage(),
      label: 'Discovery',
      activeIcon: rf_search.iconImage(iconColor: rf_primaryColor),
    ),
    BottomNavigationBarItem(
      icon: SizedBox.shrink(),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: rf_message.iconImage(),
      label: 'Chat',
      activeIcon: Icon(Icons.message),
    ),
  ];

  List<Widget> tourGuidePages = [
    RFHomeTourGuideFragment(),
    DiscoveryFragment(),
    RFMapPage(),
    WarningIncidentPage(),
    ChatPageScreen(),
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
    BottomNavigationBarItem(
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
      activeIcon: Icon(Icons.message),
    ),
  ]; //báo lỗi nếu mảng có ít hơn hoặc bằng 2 item

  Widget _bottomTab(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    List<BottomNavigationBarItem> items =
        authProvider.user.role == 'Traveler' ? travelerItems : tourGuideItems;

    if (Theme.of(context).platform == TargetPlatform.android) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: CustomCircularNotchedRectangle(
            notchOffset: Offset(-16, 0),
          ),
          notchMargin: 8.0,
          elevation: 0,
          child: Container(
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
        ),
      ).paddingOnly(left: 16, right: 16, top: 16);
    } else {
      return SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BottomAppBar(
            clipBehavior: Clip.antiAlias,
            shape: CustomCircularNotchedRectangle(
              notchOffset: Offset(-16, 0),
            ),
            notchMargin: 8.0,
            elevation: 0,
            child: CupertinoTabBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.white, // Set your desired background color
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
    setStatusBarColor(rf_primaryColor, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    List<Widget> pages = authProvider.user.role == 'Traveler' ? travelerPages : tourGuidePages;
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

class CustomCircularNotchedRectangle extends NotchedShape {
  CustomCircularNotchedRectangle({
    this.notchOffset = const Offset(0, 0),
  });
  final Offset notchOffset;

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);
    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final double notchRadius = guest.width / 2.0;
    // We build a path for the notch from 3 segments:
    // Segment A - a Bezier curve from the host's top edge to segment B.
    // Segment B - an arc with radius notchRadius.
    // Segment C - a Bezier curve from segment B back to the host's top edge.
    //
    // A detailed explanation and the derivation of the formulas below is
    // available at: goo.gl/Ufzrqn

    const double s1 = 30.0;
    const double s2 = 1.0;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final List<Offset?> p = List<Offset?>.filled(6, null);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i]! + guest.center + notchOffset;
    }

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p[0]!.dx, p[0]!.dy)
      ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
      ..arcToPoint(
        p[3]!,
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}
