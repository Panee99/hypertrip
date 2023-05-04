import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/RFCongratulatedDialog.dart';
import '../../utils/RFColors.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int selectedStatus = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppButton(
        color: rf_primaryColor,
        elevation: 0,
        child: Text('Apply Filter', style: boldTextStyle(color: white)),
        width: context.width(),
        onTap: () {},
      ).paddingSymmetric(horizontal: 16, vertical: 24),
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        leading: IconButton(
          icon: Material.Icon(Icons.arrow_back_ios_new, color: white, size: 18),
          onPressed: () {
            finish(context);
          },
        ),
        backgroundColor: rf_primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Flexible(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Status',
                      style: secondaryTextStyle(weight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: selectedStatus,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedStatus = value!;
                                });
                              },
                            ),
                            Text('Upcoming'),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: selectedStatus,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedStatus = value!;
                                });
                              },
                            ),
                            Text('Happening'),
                          ],
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 3,
                          groupValue: selectedStatus,
                          onChanged: (int? value) {
                            setState(() {
                              selectedStatus = value!;
                            });
                          },
                        ),
                        Text('Occurred'),
                      ],
                    ),
                  ],
                )),
            Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Text('Clear All'),
                      onTap: () {
                        setState(() {
                          selectedStatus = 1;
                        });
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
