import 'package:flutter/material.dart';
import '../routes.dart';
import '../widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  final List<_Section> sections = const [
    _Section(title: 'Trámites', description: 'Consulta y realiza trámites municipales', route: Routes.tramites, icon: Icons.account_balance),
    _Section(title: 'Banners', description: 'Promociona eventos y servicios', route: Routes.banners, icon: Icons.image),
    _Section(title: 'Oficios', description: 'Gestión de oficios gubernamentales', route: Routes.oficios, icon: Icons.work),
    _Section(title: 'Transporte', description: 'Información de rutas y horarios', route: Routes.transporte, icon: Icons.directions_bus),
    _Section(title: 'Basura', description: 'Horarios de recolección y reciclaje', route: Routes.basura, icon: Icons.delete),
    _Section(title: 'Anuncios', description: 'Avisos e información ciudadana', route: Routes.anuncios, icon: Icons.announcement),
    _Section(title: 'Médicos', description: 'Directorio médico y servicios de salud', route: Routes.medicos, icon: Icons.local_hospital),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'UruAPPan',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Servicios Municipales',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Accede a los servicios digitales del Gobierno de Uruapan',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: sections.length,
              itemBuilder: (context, index) => _buildCard(context, sections[index]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, _Section s) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(context).pushNamed(s.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: s.route,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(s.icon, size: 32, color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                s.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                s.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section {
  final String title;
  final String description;
  final String route;
  final IconData icon;
  const _Section({required this.title, required this.description, required this.route, required this.icon});
}
