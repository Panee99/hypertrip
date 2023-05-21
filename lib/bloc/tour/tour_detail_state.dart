import 'package:equatable/equatable.dart';
import 'package:room_finder_flutter/models/tour/tour_detail_response.dart';
import 'package:room_finder_flutter/models/tour/tour_list_response.dart';

//Tour Detail
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

class TourDetailErrorState extends TourDetailState {
  final String error;
  TourDetailErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

//Tour List
abstract class TourListState extends Equatable {}

class TourListLoadingState extends TourListState {
  @override
  List<Object?> get props => [];
}

class TourListLoadedState extends TourListState {
  TourListLoadedState(this.tourList);
  final TourListResponse tourList;
  @override
  List<Object?> get props => [tourList];
}

class TourListErrorState extends TourListState {
  final String error;
  TourListErrorState(this.error);
  List<Object?> get props => [error];
}
