// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD5hma8Y5uVWKnG0kOzurCRedMR9Er1uCM',
    appId: '1:147092371359:web:501ef87c23a1d4814dafaa',
    messagingSenderId: '147092371359',
    projectId: 'wits-services-ea5cf',
    authDomain: 'wits-services-ea5cf.firebaseapp.com',
    storageBucket: 'wits-services-ea5cf.appspot.com',
    measurementId: 'G-VQ8DBKB9T1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBi_Mkh33Qjsms3Uc9FF9vjQpLxxAySA4s',
    appId: '1:147092371359:android:1c3cfc9ee9f3a6b04dafaa',
    messagingSenderId: '147092371359',
    projectId: 'wits-services-ea5cf',
    storageBucket: 'wits-services-ea5cf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1gm216VKwqEq3oApesCakwxisuWXtkdk',
    appId: '1:147092371359:ios:ecf9d991797733a64dafaa',
    messagingSenderId: '147092371359',
    projectId: 'wits-services-ea5cf',
    storageBucket: 'wits-services-ea5cf.appspot.com',
    androidClientId: '147092371359-3vimbvq3ss26sjrk6uebmkhi5slf2595.apps.googleusercontent.com',
    iosClientId: '147092371359-p7vinu667gg68o8jk3b24r89aronojsu.apps.googleusercontent.com',
    iosBundleId: 'com.example.sdpWitsServices',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC1gm216VKwqEq3oApesCakwxisuWXtkdk',
    appId: '1:147092371359:ios:ecf9d991797733a64dafaa',
    messagingSenderId: '147092371359',
    projectId: 'wits-services-ea5cf',
    storageBucket: 'wits-services-ea5cf.appspot.com',
    androidClientId: '147092371359-3vimbvq3ss26sjrk6uebmkhi5slf2595.apps.googleusercontent.com',
    iosClientId: '147092371359-p7vinu667gg68o8jk3b24r89aronojsu.apps.googleusercontent.com',
    iosBundleId: 'com.example.sdpWitsServices',
  );
}
