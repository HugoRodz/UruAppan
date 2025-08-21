import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import '../widgets/app_scaffold.dart';
// import 'screens/tramites_screen.dart';
// import 'screens/transporte_screen.dart';
// import 'screens/medicos_screen.dart';
// import 'screens/basura_screen.dart';
// import 'screens/banners_screen.dart';
// import 'screens/oficios_screen.dart';
// import 'screens/anuncios_screen.dart';

// Pantalla temporal de trámites
class TramitesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Trámites y Servicios',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.account_balance, size: 48, color: Colors.teal),
                  SizedBox(height: 16),
                  Text(
                    'Gobierno Municipal de Uruapan',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text('Servicios y trámites disponibles para ciudadanos'),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.business, color: Colors.white),
              ),
              title: Text('Licencia de Funcionamiento'),
              subtitle: Text('Permiso para operar establecimiento comercial'),
              trailing: Text('\$2,450'),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.construction, color: Colors.white),
              ),
              title: Text('Permiso de Construcción'),
              subtitle: Text('Autorización para edificar o remodelar'),
              trailing: Text('\$3,200'),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.description, color: Colors.white),
              ),
              title: Text('Registro Civil'),
              subtitle: Text('Actas de nacimiento, matrimonio, defunción'),
              trailing: Text('\$890'),
            ),
          ),
        ],
      ),
    );
  }
}

// Pantalla temporal de transporte
class TransporteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Transporte Público',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.directions_bus, size: 48, color: Colors.blue),
                  SizedBox(height: 16),
                  Text(
                    'Sistema de Transporte Público',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text('Rutas y horarios disponibles'),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              title: Text('Ruta Centro-Revolución'),
              subtitle: Text('\$12.00 • Cada 15 minutos'),
              trailing: Text('5:30 AM - 10:30 PM'),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              title: Text('Ruta Aeropuerto-Universidad'),
              subtitle: Text('\$15.00 • Cada 20 minutos'),
              trailing: Text('6:00 AM - 9:00 PM'),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              title: Text('Ruta Periférico'),
              subtitle: Text('\$10.00 • Cada 10 minutos'),
              trailing: Text('5:00 AM - 11:00 PM'),
            ),
          ),
        ],
      ),
    );
  }
}

// Pantalla temporal de médicos
class MedicosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Servicios Médicos',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            color: Colors.red.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.emergency, size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Números de Emergencia',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text('Emergencias General: 911', style: TextStyle(fontSize: 16)),
                  Text('Cruz Roja: (452) 523-7890', style: TextStyle(fontSize: 16)),
                  Text('Hospital General: (452) 523-4567', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.local_hospital, color: Colors.white),
              ),
              title: Text('Hospital General de Uruapan'),
              subtitle: Text('Emergencias 24/7 • Av. Lázaro Cárdenas #500'),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.medical_services, color: Colors.white),
              ),
              title: Text('Centro de Salud La Magdalena'),
              subtitle: Text('Consulta General • Calle Morelos #234'),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.healing, color: Colors.white),
              ),
              title: Text('Clínica Familiar ISSSTE'),
              subtitle: Text('Medicina Familiar • Av. Revolución #890'),
            ),
          ),
        ],
      ),
    );
  }
}

// Pantalla temporal de basura
class BasuraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Recolección de Basura',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.delete, size: 48, color: Colors.green),
                  SizedBox(height: 16),
                  Text(
                    'Recolección de Residuos',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text('Horarios y zonas de recolección'),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.schedule, color: Colors.white),
              ),
              title: Text('Zona Centro'),
              subtitle: Text('Lunes, Miércoles, Viernes • 6:00 AM'),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.schedule, color: Colors.white),
              ),
              title: Text('Zona Norte'),
              subtitle: Text('Martes, Jueves, Sábado • 6:30 AM'),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.recycling, color: Colors.white),
              ),
              title: Text('Reciclaje'),
              subtitle: Text('Sábados • 8:00 AM • Material separado'),
            ),
          ),
        ],
      ),
    );
  }
}

class Routes {
  static const String home = '/';
  static const String tramites = '/tramites';
  static const String banners = '/banners';
  static const String oficios = '/oficios';
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
      // Temporarily redirect other routes to home
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
