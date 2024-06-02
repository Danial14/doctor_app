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
    apiKey: 'AIzaSyDCET0TBl-DY2fgo-6whDwHdrHAdNEWgrQ',
    appId: '1:454473763079:web:917f762269bb8597779da2',
    messagingSenderId: '454473763079',
    projectId: 'livecareai',
    authDomain: 'livecareai.firebaseapp.com',
    storageBucket: 'livecareai.appspot.com',
    measurementId: 'G-3V8SQDVWES',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBcf-ptrud1Bd8UlfsZ8kKfTwfn0WGecg',
    appId: '1:454473763079:android:e099666cb6616f1c779da2',
    messagingSenderId: '454473763079',
    projectId: 'livecareai',
    storageBucket: 'livecareai.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZc0h8t4FUGkTuTWlxxVpgw7-Y7GAwHwU',
    appId: '1:454473763079:ios:590230b68ffc1812779da2',
    messagingSenderId: '454473763079',
    projectId: 'livecareai',
    storageBucket: 'livecareai.appspot.com',
    iosClientId: '454473763079-btkgfeh79hnaap2d860tm7jju4cacorc.apps.googleusercontent.com',
    iosBundleId: 'com.sc.cliniconline',
  );
}
