import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/data/repositories/warning_incident_repository.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/interactor/warning_incident_event.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/interactor/warning_incident_state.dart';

class WarningIncidentBloc extends Bloc<WarningIncidentEvent, WarningIncidentState> {
  final WarningIncidentRepository _warningIncidentRepository;
  WarningIncidentBloc(this._warningIncidentRepository) : super(WarningIncidentLoadingState()) {
    on<FetchDataWeather>(_fetchDataWeather);
  }

  FutureOr<void> _fetchDataWeather(
      FetchDataWeather event, Emitter<WarningIncidentState> emit) async {
    final result = await _warningIncidentRepository.fetchDataWeather();
    print("result ${result}");
  }
}
