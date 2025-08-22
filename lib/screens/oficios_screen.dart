import 'package:flutter/material.dart';
import '../services/oficio_repository.dart';
import 'oficio_form.dart';
import 'oficios_admin_screen.dart';

class _Categoria {
  final String nombre;
  final IconData icon;
  final List<String> ejemplos;

  const _Categoria({required this.nombre, required this.icon, required this.ejemplos});
}

const List<_Categoria> _kCategorias = [
  _Categoria(nombre: 'Construcción y Remodelación', icon: Icons.construction, ejemplos: ['Albañil', 'Carpintero', 'Plomero', 'Yesero']),
  _Categoria(nombre: 'Servicios Domésticos', icon: Icons.home, ejemplos: ['Limpieza', 'Cocina', 'Niñera', 'Jardinería']),
  _Categoria(nombre: 'Transporte y Mudanzas', icon: Icons.local_shipping, ejemplos: ['Taxista', 'Chofer particular', 'Servicio de mudanza']),
  _Categoria(nombre: 'Tecnología y Soporte', icon: Icons.computer, ejemplos: ['Técnico en computadoras', 'Instalador de redes', 'Diseñador web']),
  _Categoria(nombre: 'Salud y Bienestar', icon: Icons.health_and_safety, ejemplos: ['Enfermería a domicilio', 'Fisioterapia', 'Masajista']),
];

class OficiosScreen extends StatelessWidget {
  const OficiosScreen({Key? key}) : super(key: key);

  void _showEjemploDetalle(BuildContext context, String categoria, String ejemplo) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$categoria • $ejemplo', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text('Ejemplo de servicio público/privado. En el futuro podrás ver información real y opciones específicas.'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => OficioForm(initialCategory: categoria)));
                      },
                      child: const Text('Registrar oficio'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cerrar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oficios / Trabajos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => OficiosAdminScreen())),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categorías de oficios y servicios', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('Explora categorías y ejemplos; pulsa en un ejemplo para ver acciones o registrar tu oficio.'),
                ],
              ),
            ),
          ),
          ..._kCategorias.map((cat) => Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ExpansionTile(
                  leading: CircleAvatar(child: Icon(cat.icon)),
                  title: Text(cat.nombre, style: const TextStyle(fontWeight: FontWeight.w600)),
                  children: cat.ejemplos
                      .map((ej) => ListTile(
                            title: Text(ej),
                            subtitle: const Text('Ejemplo de oficio / servicio'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => _showEjemploDetalle(context, cat.nombre, ej),
                          ))
                      .toList(),
                ),
              )),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.add_business),
              title: const Text('¿Eres trabajador independiente? Registra tu oficio'),
              subtitle: const Text('Publica tus datos para que la comunidad te encuentre.'),
              trailing: ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => OficioForm())),
                child: const Text('Registrar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
