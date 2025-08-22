import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/tramites_screen.dart';
import 'screens/transporte_screen.dart';
import 'screens/medicos_screen.dart';
import 'screens/basura_screen.dart';
import 'screens/banners_screen.dart';
import 'screens/oficios_screen.dart';
import 'screens/anuncios_screen.dart';

class Routes {
  static const String home = '/';
  static const String tramites = '/tramites';
  static const String banners = '/banners';
  static const String oficios = '/oficios';
  static const String login = '/login';
  static const String transporte = '/transporte';
  static const String basura = '/basura';
  static const String anuncios = '/anuncios';
  static const String medicos = '/medicos';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case tramites:
        return MaterialPageRoute(builder: (_) => TramitesScreen());
      case transporte:
        return MaterialPageRoute(builder: (_) => TransporteScreen());
      case medicos:
        return MaterialPageRoute(builder: (_) => MedicosScreen());
      case basura:
        return MaterialPageRoute(builder: (_) => BasuraScreen());
      case banners:
        return MaterialPageRoute(builder: (_) => BannersScreen());
      case oficios:
        return MaterialPageRoute(builder: (_) => OficiosScreen());
      case anuncios:
        return MaterialPageRoute(builder: (_) => AnunciosScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
