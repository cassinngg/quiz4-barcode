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
        return windows;
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
    apiKey: 'AIzaSyA5yMDL83jUX2uL7q5kJdfrpnNEYk8Fh-k',
    appId: '1:50556392366:web:d7e37062963f063c71ae3f',
    messagingSenderId: '50556392366',
    projectId: 'barcode-67f00',
    authDomain: 'barcode-67f00.firebaseapp.com',
    storageBucket: 'barcode-67f00.appspot.com',
    measurementId: 'G-MNL1LWK6E7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpyrb1kq__g8P2dpYMXWW8UGU45TRXqxU',
    appId: '1:50556392366:android:c33fdc73de7c52e571ae3f',
    messagingSenderId: '50556392366',
    projectId: 'barcode-67f00',
    storageBucket: 'barcode-67f00.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlcoriuyD_cuVA8fSHXlPhtWsQo72NEgo',
    appId: '1:50556392366:ios:71a94c9806d7c41e71ae3f',
    messagingSenderId: '50556392366',
    projectId: 'barcode-67f00',
    storageBucket: 'barcode-67f00.appspot.com',
    iosBundleId: 'com.example.barcode',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlcoriuyD_cuVA8fSHXlPhtWsQo72NEgo',
    appId: '1:50556392366:ios:71a94c9806d7c41e71ae3f',
    messagingSenderId: '50556392366',
    projectId: 'barcode-67f00',
    storageBucket: 'barcode-67f00.appspot.com',
    iosBundleId: 'com.example.barcode',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA5yMDL83jUX2uL7q5kJdfrpnNEYk8Fh-k',
    appId: '1:50556392366:web:880132a29eb7105171ae3f',
    messagingSenderId: '50556392366',
    projectId: 'barcode-67f00',
    authDomain: 'barcode-67f00.firebaseapp.com',
    storageBucket: 'barcode-67f00.appspot.com',
    measurementId: 'G-T4H2K3YWPH',
  );

}