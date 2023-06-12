import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/tour/tour_list_response.dart';
import 'tour_detail_event.dart';
import 'tour_detail_state.dart';

//Tour Detail
class TourDetailBloc extends Bloc<dynamic, TourDetailState> {
  final AppRepository appRepository;
  TourDetailBloc(this.appRepository) : super(TourDetailLoadingState()) {
    on<LoadTourDetailEvent>((event, emit) async {
      emit(TourDetailLoadingState());
      try {
        //final tourDetail = await appRepository.getTourDetail(event.tourId);
        // emit(TourDetailLoadedState(tourDetail));
      } catch (e) {
        emit(TourDetailErrorState(e.toString()));
      }
    });
  }
}

//Tour List
class TourListBloc extends Bloc<dynamic, TourListState> {
  final AppRepository appRepository;
  TourListBloc(this.appRepository) : super(TourListLoadingState()) {
    on<LoadTourListEvent>((event, emit) async {
      emit(TourListLoadingState());
      try {
        TourListResponse tourList = await appRepository.getTourList();
        emit(TourListLoadedState(tourList));
      } catch (e) {
        emit(TourListErrorState(e.toString()));
      }
    });
  }
}
