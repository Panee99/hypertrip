import 'package:equatable/equatable.dart';
import 'package:room_finder_flutter/models/tourguide/tourguide_assgined.dart';

//Tour Detail
abstract class WarningIncidentState extends Equatable {}

class WarningIncidentLoadingState extends WarningIncidentState {
  @override
  List<Object?> get props => [];
}

class WarningIncidentLoadedState extends WarningIncidentState {
  WarningIncidentLoadedState(this.assignedTourGuide);
  final TourGuideAssigned assignedTourGuide;
  @override
  List<Object?> get props => [assignedTourGuide];
}

class WarningIncidentErrorState extends WarningIncidentState {
  final String error;
  WarningIncidentErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
