import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//TourDetail
@immutable
abstract class TourDetailEvent extends Equatable {
  const TourDetailEvent();
}

class LoadTourDetailEvent extends TourDetailEvent {
  final String tourId;
  final String token;

  LoadTourDetailEvent(this.tourId, this.token);
  @override
  List<Object?> get props => [tourId, token];
}

//TourList
@immutable
abstract class TourListEvent extends Equatable {
  const TourListEvent();
}

class LoadTourListEvent extends TourListEvent {
  LoadTourListEvent();
  @override
  List<Object?> get props => [];
}
