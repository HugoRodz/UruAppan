import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/profile_service.dart';
import 'services/profile_repository.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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

    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.light);
    final ThemeData baseTheme = ThemeData.from(colorScheme: colorScheme, useMaterial3: true);

    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<ProfileService>(
          create: (_) => ProfileService()..load(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'UruAPPan',
        theme: baseTheme.copyWith(
        textTheme: baseTheme.textTheme.copyWith(
          headlineSmall: baseTheme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          titleLarge: baseTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          titleMedium: baseTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        cardTheme: baseTheme.cardTheme.copyWith(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        appBarTheme: baseTheme.appBarTheme.copyWith(
          backgroundColor: Colors.teal.shade600,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        home: AuthGate(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

class AuthGate extends StatefulWidget {
  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initProfile();
  }

  Future<void> _initProfile() async {
    final auth = Provider.of<AuthService>(context, listen: false);
    final profileSvc = Provider.of<ProfileService>(context, listen: false);
    if (auth.currentUser != null && profileSvc.selectedProfile == null) {
      try {
        final repo = ProfileRepository();
        final p = await repo.getProfileForUser(auth.currentUser!.uid);
        if (p != null) await profileSvc.setProfile(p);
      } catch (e) {
        // ignore
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final profileSvc = Provider.of<ProfileService>(context);
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    // allow public access if previously selected profile is 'Ciudadano'
    if (auth.currentUser == null && profileSvc.selectedProfile != 'Ciudadano') {
      return const LoginScreen();
    }
    return HomeScreen();
  }
}
