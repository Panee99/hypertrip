import 'package:dio/dio.dart';
import 'package:hypertrip/domain/models/activity/activity.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';

class ActivityRepo {
  final Dio apiClient = getIt.get<Dio>();

  ActivityRepo();

  Future<List<Activity>> getActivities(String tourGroupId) async {
    try {
      final response =
          await apiClient.get('/tour-groups/$tourGroupId/activities');

      return Activity.fromJsonList(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw Exception(msg_tour_group_not_found);
      }
      throw Exception(msg_server_error);
    }
  }
}