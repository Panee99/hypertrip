import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'tour_detail_event.dart';
import 'tour_detail_state.dart';

class TourDetailBloc extends Bloc<dynamic, TourDetailState> {
  final AppRepository appRepository;
  TourDetailBloc(this.appRepository) : super(TourDetailLoadingState()) {
    on<LoadTourDetailEvent>((event, emit) async {
      emit(TourDetailLoadingState());
      try {
        final tourDetail =
            await appRepository.getTourDetail(event.tourId, event.token);
        emit(TourDetailLoadedState(tourDetail));
      } catch (e) {
        emit(TourDetaileErrorState(e.toString()));
      }
    });
  }
}
