// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyDGa2P_dGGm8J5kUH0KXf_gQH4lXl5YMpg',
    appId: '1:207888267406:web:c3fd1d420b44bdac6ef1df',
    messagingSenderId: '207888267406',
    projectId: 'daily-planner-3e223',
    authDomain: 'daily-planner-3e223.firebaseapp.com',
    storageBucket: 'daily-planner-3e223.appspot.com',
    measurementId: 'G-286EHH5GMD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPFuRn_Ty11KDfHyyCKEj8x4dipQ14gzY',
    appId: '1:207888267406:android:4af694a09a4b46a86ef1df',
    messagingSenderId: '207888267406',
    projectId: 'daily-planner-3e223',
    storageBucket: 'daily-planner-3e223.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVEuXwevIO81jq9lS105TH6CC1kHOflwE',
    appId: '1:207888267406:ios:d3e573a3f3b03a9c6ef1df',
    messagingSenderId: '207888267406',
    projectId: 'daily-planner-3e223',
    storageBucket: 'daily-planner-3e223.appspot.com',
    iosBundleId: 'com.example.dailyPlanner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVEuXwevIO81jq9lS105TH6CC1kHOflwE',
    appId: '1:207888267406:ios:d3e573a3f3b03a9c6ef1df',
    messagingSenderId: '207888267406',
    projectId: 'daily-planner-3e223',
    storageBucket: 'daily-planner-3e223.appspot.com',
    iosBundleId: 'com.example.dailyPlanner',
  );
}
