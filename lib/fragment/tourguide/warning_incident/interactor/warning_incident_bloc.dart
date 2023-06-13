import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/data/repositories/warning_incident_repository.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/interactor/warning_incident_event.dart';
import 'package:room_finder_flutter/fragment/tourguide/warning_incident/interactor/warning_incident_state.dart';

class WarningIncidentBloc extends Bloc<WarningIncidentEvent, WarningIncidentState> {
  final WarningIncidentRepository _warningIncidentRepository;

  WarningIncidentBloc(this._warningIncidentRepository)
      : super(WeatherLoadingState(weatherResponse: null, earthquakesResponse: null, error: '')) {
    on<FetchDataWeather>(_fetchDataWeather);
    on<FetchDataEarthQuakes>(_fetchDataEarthQuakes);
  }

  FutureOr<void> _fetchDataWeather(
      FetchDataWeather event, Emitter<WarningIncidentState> emit) async {
    try {
      final result = await _warningIncidentRepository.fetchDataWeather();

      emit(state.copyWith(weatherResponse: result));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  FutureOr<void> _fetchDataEarthQuakes(
      FetchDataEarthQuakes event, Emitter<WarningIncidentState> emit) async {
    try {
      final result = await _warningIncidentRepository.fetchDataEarthQuakes();

      emit(state.copyWith(earthquakesResponse: result));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
