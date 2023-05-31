import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/screens/EmailSignInScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

import 'MobileSignInScreen.dart';

class RFSplashScreen extends StatefulWidget {
  @override
  _RFSplashScreenState createState() => _RFSplashScreenState();
}

class _RFSplashScreenState extends State<RFSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(rf_primaryColor,
        statusBarIconBrightness: Brightness.light);

    await Future.delayed(Duration(seconds: 2));
    finish(context);
    RFMobileSignIn().launch(context);
    // RFEmailSignInScreen().launch(context);
  }

  @override
  void dispose() {
    setStatusBarColor(rf_primaryColor,
        statusBarIconBrightness: Brightness.light);

    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rf_primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: boxDecorationWithRoundedCorners(
                boxShape: BoxShape.circle, backgroundColor: rf_splashBgColor),
            width: 250,
            height: 250,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Travel", style: boldTextStyle(color: white, size: 20)),
              4.height,
              Text("Enjoy your trip", style: primaryTextStyle(color: white)),
            ],
          ),
        ],
      ).center(),
    );
  }
}
