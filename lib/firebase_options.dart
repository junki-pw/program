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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA1PV-yiaj7dncNYWXPxMSgmqsKH05Xryw',
    appId: '1:529828806112:web:045f54c2f5fb6a49b63f85',
    messagingSenderId: '529828806112',
    projectId: 'bbbake-6e6d3',
    authDomain: 'bbbake-6e6d3.firebaseapp.com',
    databaseURL: 'https://bbbake-6e6d3-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bbbake-6e6d3.appspot.com',
    measurementId: 'G-WYKC4T95PM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAas0G09XcdN904GpHjEuj47O1VmIMJcdk',
    appId: '1:529828806112:android:fab3c82d32fdb882b63f85',
    messagingSenderId: '529828806112',
    projectId: 'bbbake-6e6d3',
    databaseURL: 'https://bbbake-6e6d3-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bbbake-6e6d3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyATtbXbAMCVfA3nkpBAnMXkTUHwF7X6Lzo',
    appId: '1:529828806112:ios:7597658f9d47ab70b63f85',
    messagingSenderId: '529828806112',
    projectId: 'bbbake-6e6d3',
    databaseURL: 'https://bbbake-6e6d3-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bbbake-6e6d3.appspot.com',
    androidClientId: '529828806112-dqem1i3690tdm46viomsf226lm587ahl.apps.googleusercontent.com',
    iosClientId: '529828806112-ups1ipgnnierl963l2npdik3gi179agt.apps.googleusercontent.com',
    iosBundleId: 'com.uniqueappt.program',
  );
}