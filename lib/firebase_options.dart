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
    apiKey: 'AIzaSyBrwX9aWjBnQjSNbSouBgW8-IjnoYywljI',
    appId: '1:966555663103:web:8051bcb31b1e7a359a2aca',
    messagingSenderId: '966555663103',
    projectId: 'choices-41be5',
    authDomain: 'choices-41be5.firebaseapp.com',
    storageBucket: 'choices-41be5.appspot.com',
    measurementId: 'G-VS0G9HSCCJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlIEHKR5UpAwmf0Bbwovj5Ova2B3T3mQM',
    appId: '1:966555663103:android:1a1e3150c23eed8a9a2aca',
    messagingSenderId: '966555663103',
    projectId: 'choices-41be5',
    storageBucket: 'choices-41be5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwZuScSpL4tPwgAWbVBAE4k1PQNJzAONc',
    appId: '1:966555663103:ios:99038648000d28109a2aca',
    messagingSenderId: '966555663103',
    projectId: 'choices-41be5',
    storageBucket: 'choices-41be5.appspot.com',
    iosClientId:
        '966555663103-26muq7s0gl3uedmua77ma2qd541u507q.apps.googleusercontent.com',
    iosBundleId: 'com.example.choices',
  );
}