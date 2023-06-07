import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/constants/firestore_constants.dart.dart';
import 'package:room_finder_flutter/constants/user_constants.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/user/avatar_response.dart';

import '../models/user/sign_in_model.dart';

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
  final SharedPreferences prefs;

  Status _status = Status.uninitialized;

  Status get status => _status;
  String _token = '';

  String get token => _token;
  late ProfileResponse _user;
  ProfileResponse get user => _user;
  late AvatarResponse _avt;
  AvatarResponse get avt => _avt;

  AuthProvider({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.prefs,
    required this.firebaseFirestore,
  });

  String? getUserFirebaseId() {
    return prefs.getString(FirestoreConstants.id);
  }

  String? getUserId() {
    return prefs.getString(UserConstants.id);
  }

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn && prefs.getString(FirestoreConstants.id)?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleSignIn(String username, String password) async {
    _status = Status.authenticating;
    notifyListeners();
    _token = await AppRepository().getToken(username, password);
    notifyListeners();
    _user = (await AppRepository().getUserProfile(_token))!;

    if (await AppRepository().getUserAvatar(_token) != null) {
      _avt = (await AppRepository().getUserAvatar(_token))!;
      notifyListeners();
    } else {
      _avt = AvatarResponse();
      notifyListeners();
    }
    if (_user != null) {
      _status = Status.authenticated;
      await prefs.setString(UserConstants.id, _user.id!);
      notifyListeners();
      return true;
    } else {
      _status = Status.authenticateError;
      notifyListeners();
      return false;
    }
  }

  // Future<bool> handleSignIn() async {
  //   _status = Status.authenticating;
  //   notifyListeners();

  //   GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //   if (googleUser != null) {
  //     GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     User? firebaseUser =
  //         (await firebaseAuth.signInWithCredential(credential)).user;

  //     if (firebaseUser != null) {
  //       final QuerySnapshot result = await firebaseFirestore
  //           .collection(FirestoreConstants.pathUserCollection)
  //           .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
  //           .get();
  //       final List<DocumentSnapshot> documents = result.docs;
  //       if (documents.length == 0) {
  //         // Writing data to server because here is a new user
  //         firebaseFirestore
  //             .collection(FirestoreConstants.pathUserCollection)
  //             .doc(firebaseUser.uid)
  //             .set({
  //           FirestoreConstants.nickname: firebaseUser.displayName,
  //           FirestoreConstants.photoUrl: firebaseUser.photoURL,
  //           FirestoreConstants.id: firebaseUser.uid,
  //           'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
  //           FirestoreConstants.chattingWith: null
  //         });

  //         // Write data to local storage
  //         User? currentUser = firebaseUser;
  //         await prefs.setString(FirestoreConstants.id, currentUser.uid);
  //         await prefs.setString(
  //             FirestoreConstants.nickname, currentUser.displayName ?? "");
  //         await prefs.setString(
  //             FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
  //       } else {
  //         // Already sign up, just get data from firestore
  //         DocumentSnapshot documentSnapshot = documents[0];
  //         UserChat userChat = UserChat.fromDocument(documentSnapshot);
  //         // Write data to local
  //         await prefs.setString(FirestoreConstants.id, userChat.id);
  //         await prefs.setString(FirestoreConstants.nickname, userChat.nickname);
  //         await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
  //         await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
  //       }
  //       _status = Status.authenticated;
  //       notifyListeners();
  //       return true;
  //     } else {
  //       _status = Status.authenticateError;
  //       notifyListeners();
  //       return false;
  //     }
  //   } else {
  //     _status = Status.authenticateCanceled;
  //     notifyListeners();
  //     return false;
  //   }
  // }

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
}
