import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/screens/RFEmailSignInScreen.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFResetPasswordScreen extends StatefulWidget {
  @override
  _RFResetPasswordScreenState createState() => _RFResetPasswordScreenState();
}

class _RFResetPasswordScreenState extends State<RFResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          commonAppBarWidget(context, title: 'App Bar', showLeadingIcon: false),
      body: Column(
        children: [
          32.height,
          Text('Enter your email address below \nto reset password',
              style: secondaryTextStyle(height: 1.5),
              textAlign: TextAlign.center),
          16.height,
          AppTextField(
            controller: emailController,
            textFieldType: TextFieldType.EMAIL,
            decoration: rfInputDecoration(
              lableText: "Email Address",
              showLableText: true,
              suffixIcon: Container(
                padding: EdgeInsets.all(2),
                decoration: boxDecorationWithRoundedCorners(
                    boxShape: BoxShape.circle, backgroundColor: redColor),
                child: Icon(Icons.done, color: Colors.white, size: 14),
              ),
            ),
          ),
          32.height,
          AppButton(
            color: rf_primaryColor,
            child: Text('Reset password', style: boldTextStyle(color: white)),
            width: context.width(),
            elevation: 0,
            onTap: () {
              RFEmailSignInScreen().launch(context);
            },
          ),
        ],
      ).paddingAll(24),
    );
  }
}
