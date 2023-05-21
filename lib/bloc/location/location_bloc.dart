import 'package:bloc/bloc.dart';
import 'package:room_finder_flutter/bloc/location/location_event.dart';
import 'package:room_finder_flutter/bloc/location/location_state.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';

class LocationBloc extends Bloc<dynamic, LocationState> {
  final GoogleRepository googleRepository;
  LocationBloc(this.googleRepository) : super(LocationLoadingState()) {
    on<LoadLocationEvent>((event, emit) async {
      emit(LocationLoadingState());
      try {
        final location = await googleRepository.getCurrentCity();
        emit(LocationLoadedState(location!));
      } catch (e) {
        emit(LocationErrorState(e.toString()));
      }
    });
  }
}
