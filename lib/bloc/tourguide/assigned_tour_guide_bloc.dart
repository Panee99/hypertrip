import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/bloc/tourguide/assigned_tour_guide_event.dart';
import 'package:room_finder_flutter/bloc/tourguide/assigned_tour_guide_state.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';

class TourDetailBloc extends Bloc<dynamic, AssignedTourGuideState> {
  final AppRepository appRepository;
  TourDetailBloc(this.appRepository) : super(AssignedTourGuideLoadingState()) {
    on<LoadAssignedTourGuide>((event, emit) async {
      emit(AssignedTourGuideLoadingState());
      try {
        // final assignedTour = await appRepository.getAssignedTourGuide(
        //     event.assignedTourId, event.token);
        // emit(AssignedTourGuideLoadedState(assignedTour));
      } catch (e) {
        // emit(AssignedTourGuideErrorState(e.toString()));
      }
    });
  }
}
