import 'package:equatable/equatable.dart';
import 'package:room_finder_flutter/models/tourguide/tourguide_assgined.dart';

//Tour Detail
abstract class AssignedTourGuideState extends Equatable {}

class AssignedTourGuideLoadingState extends AssignedTourGuideState {
  @override
  List<Object?> get props => [];
}

class AssignedTourGuideLoadedState extends AssignedTourGuideState {
  AssignedTourGuideLoadedState(this.assignedTourGuide);
  final TourGuideAssigned assignedTourGuide;
  @override
  List<Object?> get props => [assignedTourGuide];
}

class AssignedTourGuideErrorState extends AssignedTourGuideState {
  final String error;
  AssignedTourGuideErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
