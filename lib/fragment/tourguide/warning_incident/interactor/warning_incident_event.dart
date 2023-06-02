import 'package:equatable/equatable.dart';

abstract class WarningIncidentEvent extends Equatable {
  const WarningIncidentEvent();
}

class FetchDataWeather extends WarningIncidentEvent {
  const FetchDataWeather();

  @override
  List<Object> get props => [];
}
