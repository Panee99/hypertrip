import 'package:flutter/material.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

class RFTourDetail extends StatelessWidget {
  const RFTourDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, backgroundColor: rf_primaryColor),
      body: Center(
        child: Text("Chi tiết tour"),
      ),
    );
  }
}
