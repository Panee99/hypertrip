package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new com.spencerccf.app_settings.AppSettingsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin app_settings, com.spencerccf.app_settings.AppSettingsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.simform.audio_waveforms.AudioWaveformsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin audio_waveforms, com.simform.audio_waveforms.AudioWaveformsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin cloud_firestore, io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.connectivity.ConnectivityPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin connectivity_plus, dev.fluttercommunity.plus.connectivity.ConnectivityPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.fintasys.emoji_picker_flutter.EmojiPickerFlutterPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin emoji_picker_flutter, com.fintasys.emoji_picker_flutter.EmojiPickerFlutterPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_auth, io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_core, io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.database.FirebaseDatabasePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_database, io.flutter.plugins.firebase.database.FirebaseDatabasePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_messaging, io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_local_notifications, com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new net.jonhanson.flutter_native_splash.FlutterNativeSplashPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_native_splash, net.jonhanson.flutter_native_splash.FlutterNativeSplashPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_plugin_android_lifecycle, io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin fluttertoast, io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.baseflow.geolocator.GeolocatorPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin geolocator_android, com.baseflow.geolocator.GeolocatorPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.googlemaps.GoogleMapsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin google_maps_flutter_android, io.flutter.plugins.googlemaps.GoogleMapsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.imagepicker.ImagePickerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin image_picker_android, io.flutter.plugins.imagepicker.ImagePickerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.nb.nb_utils.NbUtilsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin nb_utils, com.nb.nb_utils.NbUtilsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin path_provider_android, io.flutter.plugins.pathprovider.PathProviderPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.baseflow.permissionhandler.PermissionHandlerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin permission_handler_android, com.baseflow.permissionhandler.PermissionHandlerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new net.touchcapture.qr.flutterqr.FlutterQrPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin qr_code_scanner, net.touchcapture.qr.flutterqr.FlutterQrPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin shared_preferences_android, io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.tekartik.sqflite.SqflitePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin sqflite, com.tekartik.sqflite.SqflitePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin url_launcher_android, io.flutter.plugins.urllauncher.UrlLauncherPlugin", e);
    }
  }
}
