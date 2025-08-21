import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes.dart';
import 'firebase_options.dart';
import 'widgets/app_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    // Print framework errors to console during development
    FlutterError.dumpErrorToConsole(details);
  };

  bool firebaseInitOk = true;
  String? firebaseError;

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, st) {
    firebaseInitOk = false;
    firebaseError = '$e\n$st';
    // Log to console
    print('Firebase init error: $e');
    print(st);
  }

  runApp(UruApp(firebaseInitOk: firebaseInitOk, firebaseError: firebaseError));
}

class UruApp extends StatelessWidget {
  final bool firebaseInitOk;
  final String? firebaseError;

  UruApp({this.firebaseInitOk = true, this.firebaseError});
  @override
  Widget build(BuildContext context) {
    if (!firebaseInitOk) {
      return MaterialApp(
        title: 'UruAPPan',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
          appBar: AppBar(title: const Text('UruAPPan - Error')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(child: Text(firebaseError ?? 'Unknown Firebase init error')),
          ),
        ),
      );
    }

    final ThemeData base = ThemeData.light();
    return MaterialApp(
      title: 'UruAPPan',
      theme: base.copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: base.textTheme.copyWith(
          headlineSmall: base.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          titleLarge: base.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          titleMedium: base.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade600,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.home,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
