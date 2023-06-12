import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/components/rf_warning_incident_item.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/interactor/warning_incident_bloc.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/interactor/warning_incident_event.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/interactor/warning_incident_state.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';

class WarningIncidentPage extends StatelessWidget {
  const WarningIncidentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GetIt.I.get<WarningIncidentBloc>()..add(FetchDataWeather()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Warning for incident'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: rf_primaryColor,
        ),
        body: BlocBuilder<WarningIncidentBloc, WarningIncidentState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text('Wearther', style: boldTextStyle(size: 18)),
                8.height,
                RFWarningIncidentItem(),
                16.height,
                Text('Earthquakes', style: boldTextStyle(size: 18)),
                8.height,
                RFWarningIncidentItem(),
              ],
            );
          },
        ),
      ),
    );
  }
}
