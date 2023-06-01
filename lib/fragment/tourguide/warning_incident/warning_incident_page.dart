import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/components/rf_warning_incident_item.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

class WarningIncidentPage extends StatelessWidget {
  const WarningIncidentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warning for incident'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: rf_primaryColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('Wearther'),
          8.height,
          RFWarningIncidentItem(),
          16.height,
          Text('Earthquakes'),
          8.height,
          RFWarningIncidentItem(),
        ],
      ),
    );
  }
}
