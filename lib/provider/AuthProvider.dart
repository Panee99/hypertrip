import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:room_finder_flutter/constants/firestore_constants.dart.dart';
import 'package:room_finder_flutter/constants/user_constants.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/managers/firebase_messaging_manager.dart';
import 'package:room_finder_flutter/models/user/avatar_response.dart';

import '../models/user/profile_response.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateException,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  Status _status = Status.uninitialized;

  Status get status => _status;
  String _token = '';

  String get token => _token;
  late ProfileResponse _user;
  ProfileResponse get user => _user;
  late AvatarResponse _avt;
  AvatarResponse get avt => _avt;

  final _userConstants = GetIt.I.get<UserConstants>();

  AuthProvider({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firebaseFirestore,
  });

  String? getUserId() => _userConstants.getUserId();

  String? getUserFirebaseId() {
    return _userConstants.prefs?.getString(FirestoreConstants.id);
  }

  Future<bool> handleSignIn(String username, String password) async {
    _status = Status.authenticating;
    notifyListeners();
    _token = await AppRepository().getToken(username, password);
    notifyListeners();
    _user = (await AppRepository().getUserProfile(_token))!;

    _initFirebaseFCM();

    if (await AppRepository().getUserAvatar(_token) != null) {
      _avt = (await AppRepository().getUserAvatar(_token))!;
      notifyListeners();
    } else {
      _avt = AvatarResponse();
      notifyListeners();
    }
    if (_user != null) {
      _status = Status.authenticated;

      await _userConstants.setUserId(_user.id!);
      notifyListeners();
      return true;
    } else {
      _status = Status.authenticateError;
      notifyListeners();
      return false;
    }
  }

  void handleException() {
    _status = Status.authenticateException;
    notifyListeners();
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }

  void _initFirebaseFCM() {
    final fcmManager = GetIt.I.get<FirebaseMessagingManager>();
    if (_user.id != null) {
      fcmManager.registerTokenFCM(_user.id!);
      fcmManager.processInitialMessage();
    }
  }
}
