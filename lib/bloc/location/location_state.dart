import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {}

class LocationLoadingState extends LocationState {
  @override
  List<Object?> get props => [];
}

class LocationLoadedState extends LocationState {
  LocationLoadedState(this.location);
  final String location;
  @override
  List<Object?> get props => [location];
}

class LocationErrorState extends LocationState {
  LocationErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
