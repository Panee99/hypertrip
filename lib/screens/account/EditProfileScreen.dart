import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

import '../../components/RFCongratulatedDialog.dart';
import '../../utils/RFColors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode lastnameFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode birthdayFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();

  // Show the modal that contains the CupertinoDatePicker
  void _showDatePicker(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 250,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 250,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        maximumDate: DateTime.now(),
                        use24hFormat: true,
                        onDateTimeChanged: (val) {
                          setState(() {
                            birthdayController.text =
                                DateFormat('dd/MM/yyyy').format(val);
                          });
                        }),
                  ),
                ],
              ),
            ));
  }

  void _showGenderPicker(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              title: const Text('Gender'),
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  child: const Text('Male'),
                  onPressed: () {
                    genderController.text = 'Male';
                    Navigator.pop(context);
                  },
                ),
                CupertinoActionSheetAction(
                  child: const Text('Female'),
                  onPressed: () {
                    genderController.text = 'Female';
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

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
      appBar: commonAppBarWidget(context,
          title: 'Edit Profile', roundCornerShape: true, appBarHeight: 80),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Personal Information',
                style: boldTextStyle(size: 18),
              ),
              16.height,
              AppTextField(
                controller: firstnameController,
                focus: firstnameFocusNode,
                nextFocus: lastnameFocusNode,
                textFieldType: TextFieldType.NAME,
                decoration: rfInputDecoration(
                  lableText: 'First Name',
                  showLableText: true,
                ),
              ),
              16.height,
              AppTextField(
                controller: lastnameController,
                focus: lastnameFocusNode,
                nextFocus: addressFocusNode,
                textFieldType: TextFieldType.NAME,
                decoration: rfInputDecoration(
                  lableText: 'Last Name',
                  showLableText: true,
                ),
              ),
              16.height,
              AppTextField(
                controller: addressController,
                focus: addressFocusNode,
                nextFocus: emailFocusNode,
                textFieldType: TextFieldType.MULTILINE,
                decoration: rfInputDecoration(
                  lableText: 'Address',
                  showLableText: true,
                ),
              ),
              16.height,
              AppTextField(
                controller: birthdayController,
                focus: birthdayFocusNode,
                nextFocus: genderFocusNode,
                textFieldType: TextFieldType.OTHER,
                readOnly: true,
                decoration: rfInputDecoration(
                  lableText: 'Birthday',
                  showLableText: true,
                ),
                onTap: () {
                  _showDatePicker(context);
                },
              ),
              16.height,
              AppTextField(
                controller: genderController,
                focus: genderFocusNode,
                textFieldType: TextFieldType.OTHER,
                readOnly: true,
                decoration: rfInputDecoration(
                  lableText: 'Gender',
                  showLableText: true,
                ),
                onTap: () {
                  _showGenderPicker(context);
                },
              ),
              32.height,
              Text(
                'Change Password',
                style: boldTextStyle(size: 18),
              ),
              16.height,
              AppTextField(
                controller: lastnameController,
                focus: lastnameFocusNode,
                nextFocus: addressFocusNode,
                textFieldType: TextFieldType.PASSWORD,
                decoration: rfInputDecoration(
                  lableText: 'Current Password',
                  showLableText: true,
                ),
              ),
              16.height,
              AppTextField(
                controller: lastnameController,
                focus: lastnameFocusNode,
                nextFocus: addressFocusNode,
                textFieldType: TextFieldType.PASSWORD,
                decoration: rfInputDecoration(
                  lableText: 'New Password',
                  showLableText: true,
                ),
              ),
              16.height,
              AppTextField(
                controller: lastnameController,
                focus: lastnameFocusNode,
                nextFocus: addressFocusNode,
                textFieldType: TextFieldType.PASSWORD,
                decoration: rfInputDecoration(
                  lableText: 'Confirm New Password',
                  showLableText: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
