import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//TourDetail
@immutable
abstract class AssignedTourGuide extends Equatable {
  const AssignedTourGuide();
}

class LoadAssignedTourGuide extends AssignedTourGuide {
  final String assignedTourId;
  final String token;

  LoadAssignedTourGuide(this.assignedTourId, this.token);
  @override
  List<Object?> get props => [assignedTourId, token];
}
