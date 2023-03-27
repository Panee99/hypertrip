import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/RFAccountFragment.dart';
import 'package:room_finder_flutter/fragment/RFHomeFragment.dart';
import 'package:room_finder_flutter/fragment/RFSettingsFragment.dart';
import 'package:room_finder_flutter/fragment/inbox_fragment.dart';
import 'package:room_finder_flutter/fragment/ticket/ticket_fragment.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../fragment/discovery/map_fragment.dart';

class RFHomeScreen extends StatefulWidget {
  @override
  _RFHomeScreenState createState() => _RFHomeScreenState();
}

class _RFHomeScreenState extends State<RFHomeScreen> {
  int _selectedIndex = 0;

  var _pages = [
    RFHomeFragment(),
    MapFragment(),
    // RFSettingsFragment(),
    TicketFragment(),
    RFSettingsFragment(),
    RFAccountFragment(),
    InboxFragment(),
  ];

  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedLabelStyle: boldTextStyle(size: 14),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: rf_home.iconImage(),
          label: 'Home',
          activeIcon:
              Icon(Icons.home_outlined, color: rf_primaryColor, size: 22),
        ),
        BottomNavigationBarItem(
          icon: rf_search.iconImage(),
          label: 'Discovery',
          activeIcon: rf_search.iconImage(iconColor: rf_primaryColor),
        ),
        BottomNavigationBarItem(
          icon: rf_ticket.iconImage(size: 22),
          label: 'Ticket',
          activeIcon: rf_ticket.iconImage(iconColor: rf_primaryColor, size: 22),
        ),
        BottomNavigationBarItem(
          icon: rf_person.iconImage(),
          label: 'Account',
          activeIcon: rf_person.iconImage(iconColor: rf_primaryColor),
        ),
        BottomNavigationBarItem(
          icon: rf_message.iconImage(),
          label: 'Inbox',
          activeIcon: Icon(Icons.message),
        ),
      ],
    );
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
    return Scaffold(
      bottomNavigationBar: _bottomTab(),
      body: Center(child: _pages.elementAt(_selectedIndex)),
    );
  }
}
