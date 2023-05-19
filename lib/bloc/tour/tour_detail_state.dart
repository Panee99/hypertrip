import 'package:equatable/equatable.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';

abstract class TourDetailState extends Equatable {}

class TourDetailLoadingState extends TourDetailState {
  @override
  List<Object?> get props => [];
}

class TourDetailLoadedState extends TourDetailState {
  TourDetailLoadedState(this.tourDetail);
  final TourDetailResponse tourDetail;
  @override
  List<Object?> get props => [tourDetail];
}

class TourDetaileErrorState extends TourDetailState {
  final String error;
  TourDetaileErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
