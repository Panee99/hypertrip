import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/injection_container.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/provider/chatProvider.dart';
import 'package:room_finder_flutter/provider/home_provider.dart';
import 'package:room_finder_flutter/provider/setting_provider.dart';
import 'package:room_finder_flutter/routers.dart';
import 'package:room_finder_flutter/screens/RFSplashScreen.dart';
import 'package:room_finder_flutter/store/AppStore.dart';
import 'package:room_finder_flutter/utils/AppTheme.dart';
import 'package:room_finder_flutter/utils/RFConstant.dart';

import 'data/repositories/repositories.dart';
import 'firebase_options.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

  await setupDependencies();

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // Setup firebase listener for permission changes
  firebaseAuth.authStateChanges().listen((user) async {
    if (user == null) {
      try {
        debugPrint('User is currently signed out!');
        final UserCredential user = await firebaseAuth.signInAnonymously();
        final User? currentUser = firebaseAuth.currentUser;

        assert(user.user?.uid == currentUser?.uid);
      } catch (error, stacktrace) {
        debugPrint('ex ${error}');
      }
    } else {
      debugPrint('User is signed in!');
    }
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp(prefs: prefs));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            firebaseAuth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
          ),
        ),
        Provider<SettingProvider>(
          create: (_) => SettingProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
        Provider<HomeProvider>(
          create: (_) => HomeProvider(
            firebaseFirestore: this.firebaseFirestore,
          ),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
        RepositoryProvider(
          create: (context) => FoursquareRepository(),
        )
      ],
      child: MaterialApp(
        scrollBehavior: SBehavior(),
        navigatorKey: navigatorKey,
        title: 'Travel',
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.lightTheme,
        darkTheme: AppThemeData.darkTheme,
        themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        home: RFSplashScreen(),
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
