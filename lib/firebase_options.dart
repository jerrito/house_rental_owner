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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBg2YnmKyqpJX61sf5cBdjGXWHNCk1VwHs',
    appId: '1:949622844363:android:341eee1d7356129154e44e',
    messagingSenderId: '949622844363',
    projectId: 'woww-b2885',
    databaseURL: 'https://woww-b2885.firebaseio.com',
    storageBucket: 'woww-b2885.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKU9gMs1ywNDk6LpSKJFf3mUmV3ilwVhw',
    appId: '1:949622844363:ios:b18fbf89061c86c954e44e',
    messagingSenderId: '949622844363',
    projectId: 'woww-b2885',
    databaseURL: 'https://woww-b2885.firebaseio.com',
    storageBucket: 'woww-b2885.appspot.com',
    androidClientId: '949622844363-0uk11krrl4psr7j47gn2nl92id9olbgh.apps.googleusercontent.com',
    iosClientId: '949622844363-uil9p52jqef0ep1t6nhojt07k77ut3mp.apps.googleusercontent.com',
    iosBundleId: 'com.example.houseRentalAdmin',
  );
}
