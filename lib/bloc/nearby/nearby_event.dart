import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PlaceEvent extends Equatable {
  const PlaceEvent();
}

class LoadPlaceEvent extends PlaceEvent {
  @override
  List<Object?> get props => [];
}
