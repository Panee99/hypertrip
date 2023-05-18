import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../../components/RFCongratulatedDialog.dart';
import '../../utils/RFColors.dart';

class WarningSettingScreen extends StatefulWidget {
  const WarningSettingScreen({super.key});

  @override
  State<WarningSettingScreen> createState() => _WarningSettingScreenState();
}

class _WarningSettingScreenState extends State<WarningSettingScreen> {
  TextEditingController phone1Controller = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController phone3Controller = TextEditingController();
  TextEditingController messageController = TextEditingController();
  FocusNode phone1FocusNode = FocusNode();
  FocusNode phone2FocusNode = FocusNode();
  FocusNode phone3FocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppButton(
        color: rf_primaryColor,
        elevation: 0,
        child: Text('Save', style: boldTextStyle(color: white)),
        width: context.width(),
        onTap: () {
          showInDialog(context, barrierDismissible: true, builder: (context) {
            return RFCongratulatedDialog();
          });
        },
      ).paddingSymmetric(horizontal: 16, vertical: 24),
      appBar: commonAppBarWidget(context, title: 'App Bar'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Emergency Number',
              style: boldTextStyle(size: 18),
            ),
            16.height,
            AppTextField(
              controller: phone1Controller,
              focus: phone1FocusNode,
              nextFocus: phone2FocusNode,
              textFieldType: TextFieldType.PHONE,
              decoration: rfInputDecoration(
                lableText: 'Phone Number 1',
                showLableText: true,
              ),
            ),
            16.height,
            AppTextField(
              controller: phone2Controller,
              focus: phone2FocusNode,
              nextFocus: phone3FocusNode,
              textFieldType: TextFieldType.PHONE,
              decoration: rfInputDecoration(
                lableText: 'Phone Number 2',
                showLableText: true,
              ),
            ),
            16.height,
            AppTextField(
              controller: phone3Controller,
              focus: phone3FocusNode,
              textFieldType: TextFieldType.PHONE,
              decoration: rfInputDecoration(
                lableText: 'Phone Number 3',
                showLableText: true,
              ),
            ),
            16.height,
            Text(
              'Urgent Message',
              style: boldTextStyle(size: 18),
            ),
            16.height,
            AppTextField(
              controller: messageController,
              focus: messageFocusNode,
              textFieldType: TextFieldType.MULTILINE,
              decoration: rfInputDecoration(
                lableText: 'Urgent Message',
                showLableText: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
