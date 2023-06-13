import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/firebase_message.dart';

class FirebaseMessagingManager {
  final AppRepository _appRepository;

  FirebaseMessagingManager(this._appRepository);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? _latestProcessedInitialMessageId;

  setupFirebaseFCM() async {
    initNotificationsSettings();

    // Push Notification arrives when the App is in Opened and in Foreground
    FirebaseMessaging.onMessage.listen((message) {
      _handleForegroundNotification(message);
    });

    // Push Notification is clicked
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationActionFromRemoteMessage(message);
    });
  }

  Future<void> initNotificationsSettings() async {
    // Config FirebaseMessaging Plugin - Used for iOS
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  Future<void> _handleForegroundNotification(RemoteMessage message) async {
    // Xử lý khi app đang được bật
    // Update unread count
    _handleNotificationActionFromRemoteMessage(message);
  }

  /// When the user taps on a Notification with the Application close we have
  /// to consume it ones the App is completely started.
  void processInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        if (_latestProcessedInitialMessageId == null ||
            _latestProcessedInitialMessageId != message.messageId) {
          debugPrint('Processing Initial Message');
          _latestProcessedInitialMessageId = message.messageId;
          _handleNotificationActionFromRemoteMessage(message);
        } else {
          debugPrint('Initial Message Already Processed');
        }
      }
    });
  }

  void _handleNotificationActionFromRemoteMessage(RemoteMessage message) {
    debugPrint('NEW NOTIFICATION _handleNotificationActionFromRemoteMessage ${message.toString()}');
    _handleNotificationAction(FirebaseMessage.fromJson(message.data));
  }

  void _handleNotificationAction(FirebaseMessage notificationMessage) {
    debugPrint('NEW NOTIFICATION ${notificationMessage.toString()}');

    performNotificationAction(notificationMessage);
  }

  void performNotificationAction(FirebaseMessage messageNotify) {}

  Future<void> deleteToken() => _firebaseMessaging.deleteToken();

  Future<String?> getNotificationToken() => _firebaseMessaging.getToken();

  /// Register Firebase Token to Server
  void registerTokenFCM() async {
    await _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
    getNotificationToken().then((firebaseToken) async {
      String? firebaseTokenLocal = null;
      if (firebaseToken != null) {
        if (firebaseTokenLocal == null || firebaseTokenLocal != firebaseToken) {
          _appRepository.addTokenFCMApi(firebaseToken, 'user').then((value) {});
          debugPrint("firebase Token: $firebaseToken");
        }
      }
    });
  }

  /// Remove Firebase Token to Server
  Future<void> clearToken() async {
    var fcmToken = await getNotificationToken();
    if (fcmToken != null) {
      deleteToken();
      // await _appShared.setTokenFcm('');
      await _appRepository.deleteTokenFCMApi(fcmToken);
    }
  }
}
