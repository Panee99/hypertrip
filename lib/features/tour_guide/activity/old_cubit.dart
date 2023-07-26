// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:hypertrip/domain/enums/activity_type.dart';
// import 'package:hypertrip/domain/models/activity/activity.dart';
// import 'package:hypertrip/domain/repositories/activity_repo.dart';
// import 'package:hypertrip/exceptions/request_exception.dart';
// import 'package:hypertrip/extensions/enum.dart';
// import 'package:hypertrip/extensions/string.dart';

// import 'state.dart';

// class ActivityCubit extends Cubit<ActivityState> {
//   final ActivityRepo _activityRepo = ActivityRepo();
//   final BuildContext context;

//   ActivityCubit(this.context) : super(ActivityState());

//   void getActivities(
//       {required String tourGroupId, required int totalDays}) async {
//     try {
//       emit(ActivityInProgressState());
//       var activities = await _activityRepo.getActivities(tourGroupId);
//       var filteredActivities = _filterActivity(activities, state);
//       emit(ActivitySuccessState(state.copyWith(
//         activities: activities,
//         filteredActivities: filteredActivities,
//         totalDays: totalDays,
//         tourGroupId: tourGroupId,
//       )));
//     } on RequestException catch (error) {
//       emit(ActivityFailureState(error.toString()));
//     }
//   }

//   void setError(String message) {
//     emit(ActivityFailureState(message));
//   }

//   void setFilter({String? filterText, ActivityType? filterType, int? day}) {
//     var newState = state.copyWith(
//       filterText: filterText,
//       filterType: filterType,
//       selectedDay: day,
//     );

//     var filteredActivities = _filterActivity(state.activities, newState);

//     emit(ActivitySuccessState(newState.copyWith(
//       filteredActivities: filteredActivities,
//     )));
//   }
// }

// List<Activity> _filterActivity(List<Activity> activities, ActivityState state) {
//   return activities
//       .where((activity) =>
//           state.filterType == ActivityType.All ||
//           state.filterType.compareWithString(activity.type))
//       .where((activity) => activity.data['dayNo'] - 1 == state.selectedDay)
//       .where((activity) =>
//               state.filterText.isEmpty ||
//               activity.data['title'].toString().applySearch(state.filterText)
//           // || activity.data['note'].toString().applySearch(state.filterText)
//           )
//       .toList();
// }