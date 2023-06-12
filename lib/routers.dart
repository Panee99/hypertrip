import 'package:flutter/material.dart';
import 'package:room_finder_flutter/fragment/tourguide/notification/rf_notification_page.dart';
import 'package:room_finder_flutter/fragment/tourguide/profile/rf_account_fragment.dart';
import 'package:room_finder_flutter/fragment/tourguide/tour_detail/rf_tour_detail.dart';
import 'package:room_finder_flutter/fragment/tourguide/tour_list/rf_tour_list.dart';
import 'package:room_finder_flutter/models/chat/firestore_group_chat.dart';
import 'package:room_finder_flutter/screens/chat_detail/chat_detail_page.dart';
import 'package:room_finder_flutter/screens/home/nearby_you.dart';

class Routers {
  static const String ROOT = "/";
  static const String SETTING = "/setting";
  static const String TOUR_DETAIL = "/tour-detail";
  static const String TOUR_LIST = "/tour-list";
  static const String NOTIFICATION = "/notify-list";
  static const String NEAR_BY_YOU = "/near-by-you";
  static const String CHAT_DETAIL = "/chat-detail";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    print("SCREEN: " + (settings.name ?? ''));
    switch (settings.name) {
      case SETTING:
        return _animRoute(RFAccountFragment(), beginOffset: right);
      case TOUR_DETAIL:
        return _animRoute(RFTourDetail(), beginOffset: right);
      case TOUR_LIST:
        return _animRoute(RFTourList(), beginOffset: right);
      case NOTIFICATION:
        return _animRoute(RFNotificationPage(), beginOffset: right);
      case NEAR_BY_YOU:
        return _animRoute(NearbyYou(category: arguments.toString()), beginOffset: bottom);
      case CHAT_DETAIL:
        return _animRoute(
            ChatDetailPage(
              firestoreGroupChat: arguments as FirestoreGroupChat,
            ),
            beginOffset: right);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Route _animRoute(Widget page, {Offset? beginOffset}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = beginOffset ?? Offset(0.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static Offset center = Offset(0.0, 0.0);
  static Offset top = Offset(0.0, 1.0);
  static Offset bottom = Offset(0.0, -1.0);
  static Offset left = Offset(-1.0, 0.0);
  static Offset right = Offset(1.0, 0.0);
}
