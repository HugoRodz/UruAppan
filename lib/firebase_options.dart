// Firebase configuration for UruAPPan.
// Web config copied from your Firebase console.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => web;

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmXodJIYu164_SCBijbGqY4Sl3KGkbzoQ',
    appId: '1:80997830920:android:2977c16e8a544cbd3d9cbd',
    messagingSenderId: '80997830920',
    projectId: 'uruaappan',
    storageBucket: 'uruaappan.firebasestorage.app',
  );

  // Android placeholder - replace appId when available or run `flutterfire configure`

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJAZ108jyXQXJr0mw_KVosgQ2MzLHeJZk',
    appId: '1:80997830920:ios:d55cfd14c7d3ad443d9cbd',
    messagingSenderId: '80997830920',
    projectId: 'uruaappan',
    storageBucket: 'uruaappan.firebasestorage.app',
    iosBundleId: 'com.example.uruappan',
  );

  // iOS placeholder - replace appId/ids when available or run `flutterfire configure`

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBqK-ZVmki-fQqrVrZ0UufzOOa53G8GKhw',
    appId: '1:80997830920:web:54c220f850f3ed7c3d9cbd',
    messagingSenderId: '80997830920',
    projectId: 'uruaappan',
    authDomain: 'uruaappan.firebaseapp.com',
    storageBucket: 'uruaappan.firebasestorage.app',
    measurementId: 'G-3DCYZG18M2',
  );

  // Web config provided
}