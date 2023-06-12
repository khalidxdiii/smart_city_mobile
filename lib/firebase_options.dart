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
    apiKey: 'AIzaSyBK02MSrKk40MtdfWa1ZPYltB77XECEShA',
    appId: '1:16083429342:web:798f09d38c65e6f0e5df4f',
    messagingSenderId: '16083429342',
    projectId: 'smart-city-fe56d',
    authDomain: 'smart-city-fe56d.firebaseapp.com',
    storageBucket: 'smart-city-fe56d.appspot.com',
    measurementId: 'G-74GJSM0WCQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9UXisv4LYxjXieTtiyuaz9yRfLh3ACBo',
    appId: '1:16083429342:android:bfe560bc4fbde683e5df4f',
    messagingSenderId: '16083429342',
    projectId: 'smart-city-fe56d',
    storageBucket: 'smart-city-fe56d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBM_oRtYsdAFW2Yoh5JFOGcuRO9Dh538hk',
    appId: '1:16083429342:ios:7fb095044bd52331e5df4f',
    messagingSenderId: '16083429342',
    projectId: 'smart-city-fe56d',
    storageBucket: 'smart-city-fe56d.appspot.com',
    iosClientId: '16083429342-iqn4alcsbchdoguqb1sun1erh66222rr.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartCityMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBM_oRtYsdAFW2Yoh5JFOGcuRO9Dh538hk',
    appId: '1:16083429342:ios:7fb095044bd52331e5df4f',
    messagingSenderId: '16083429342',
    projectId: 'smart-city-fe56d',
    storageBucket: 'smart-city-fe56d.appspot.com',
    iosClientId: '16083429342-iqn4alcsbchdoguqb1sun1erh66222rr.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartCityMobile',
  );
}
