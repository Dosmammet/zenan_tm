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
    apiKey: 'AIzaSyCeaw_gVN0iQwFHyuF8pQ6PbVDmSVQw8AY',
    appId: '1:1049699819506:web:a4b5e3bedc729aab89956b',
    messagingSenderId: '1049699819506',
    projectId: 'stackfood-bd3ee',
    authDomain: 'stackfood-bd3ee.firebaseapp.com',
    storageBucket: 'stackfood-bd3ee.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBScz65YN8J9YoKdtKPl4ecCB3Vkc7iNL8',
    appId: '1:1049699819506:android:c80cf797b22c81f089956b',
    messagingSenderId: '1049699819506',
    projectId: 'stackfood-bd3ee',
    storageBucket: 'stackfood-bd3ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAoKfWy_MWrA0cdFRs65aBMWXSBzFGGDY',
    appId: '1:268090720915:ios:09deab0bc981199d9ac366',
    messagingSenderId: '268090720915',
    projectId: 'zenan-84bf9',
    storageBucket: 'zenan-84bf9.firebasestorage.app',
    // androidClientId:
    //     '1049699819506-8dga73jjtr36sd82cd5ijhgcu0p14p3g.apps.googleusercontent.com',
    // iosClientId:
    //     '1049699819506-2magqnhq5chvmvj75v287hngt3qb13rr.apps.googleusercontent.com',
    iosBundleId: 'com.zenan.zenan',
  );
}
