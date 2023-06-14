import 'package:nb_utils/nb_utils.dart';

class UserConstants {
  final keyId = 'id';
  final keyFcmToken = 'fcm_token';
  final keyUnReadChat = 'unread_chat';

  SharedPreferences? prefs;

  UserConstants() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
  }
  Future<void> setTokenLocalFcm(String firebaseToken) async {
    await prefs?.setString(keyFcmToken, firebaseToken);
  }

  String getTokenLocalFcm() => prefs?.getString(keyFcmToken) ?? '';

  Future<void> setNotifyMess(bool value) async {
    await prefs?.setBool(keyUnReadChat, value);
  }

  Stream<bool> watchNotifyMess() async* {
    while (true) {
      final value = prefs?.getBool(keyUnReadChat) ?? false;
      yield value;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  String? getUserFirebaseId() {
    return prefs?.getString(keyId);
  }

  String? getUserId() {
    return prefs?.getString(keyId);
  }

  Future<void> setUserId(String value) async {
    await prefs?.setString(keyId, value);
  }
}
