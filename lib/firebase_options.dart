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
    apiKey: 'AIzaSyCM6Y4DQSujn50VybuuRqpfz9Rd6nIB9gA',
    appId: '1:959140282321:web:362674d5185ff62c346af0',
    messagingSenderId: '959140282321',
    projectId: 'hike-navigator',
    authDomain: 'hike-navigator.firebaseapp.com',
    storageBucket: 'hike-navigator.appspot.com',
    measurementId: 'G-ELSB3P6TZ1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBM4v9i2_wKlk9KuSNEsJZb56ocFjs52go',
    appId: '1:959140282321:android:a49129e695254cf8346af0',
    messagingSenderId: '959140282321',
    projectId: 'hike-navigator',
    storageBucket: 'hike-navigator.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCetw9H1lWV5v-CHdMQkSOkznfIEmG8Cz8',
    appId: '1:959140282321:ios:ded1ddb87276e5bc346af0',
    messagingSenderId: '959140282321',
    projectId: 'hike-navigator',
    storageBucket: 'hike-navigator.appspot.com',
    iosClientId: '959140282321-4a84f5501s6s980if0bbvs3pqamer44b.apps.googleusercontent.com',
    iosBundleId: 'com.example.hikeNavigator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCetw9H1lWV5v-CHdMQkSOkznfIEmG8Cz8',
    appId: '1:959140282321:ios:563140a2b9103971346af0',
    messagingSenderId: '959140282321',
    projectId: 'hike-navigator',
    storageBucket: 'hike-navigator.appspot.com',
    iosClientId: '959140282321-1bdt4kuak0qulef3nec2ncldj7cqpjhd.apps.googleusercontent.com',
    iosBundleId: 'com.example.hikeNavigator.RunnerTests',
  );
}
