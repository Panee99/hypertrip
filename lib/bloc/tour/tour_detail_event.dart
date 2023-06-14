import 'package:equatable/equatable.dart';

//TourDetail
abstract class TourDetailEvent extends Equatable {
  const TourDetailEvent();
}

class LoadTourDetailEvent extends TourDetailEvent {
  final String tourId;
  final String token;

  const LoadTourDetailEvent(this.tourId, this.token);
  @override
  List<Object?> get props => [tourId, token];
}

//TourList
abstract class TourListEvent extends Equatable {
  const TourListEvent();
}

class LoadTourListEvent extends TourListEvent {
  const LoadTourListEvent();
  @override
  List<Object?> get props => [];
}
