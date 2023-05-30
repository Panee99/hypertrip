import 'package:flutter/material.dart';

class Routers {
  static const String ROOT = "/";
  static const String SPLASH = "/splash";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    print("SCREEN: " + (settings.name ?? ''));
    switch (settings.name) {
      case SPLASH:
      // return _animRoute(SplashPage());
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