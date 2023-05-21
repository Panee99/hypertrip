import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class LoadLocationEvent extends LocationEvent {
  LoadLocationEvent();
  @override
  List<Object?> get props => [];
}
