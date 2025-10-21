import 'package:flutter/material.dart';
import '../routes.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../widgets/app_scaffold.dart';
import '../services/banner_repository.dart';
import '../models/banner_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final auth = Provider.of<AuthService>(context, listen: false);
    final profile = Provider.of<ProfileService>(context).selectedProfile;
    final isGuest = auth.currentUser == null && (profile == null || profile == 'Ciudadano');
    return AppScaffold(
      title: 'UruAPPan',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroHeader(),
            if (isGuest) ...[
              const SizedBox(height: 12),
              _GuestLoginCard(),
            ],
            const SizedBox(height: 12),
            _TopBanners(),
            const SizedBox(height: 12),
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: s.route,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withAlpha((0.12 * 255).round()),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(s.icon, size: 32, color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: Text(
                  s.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  s.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuestLoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.teal.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.teal.shade100)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: Colors.teal.shade100, child: const Icon(Icons.person_outline, color: Colors.teal)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Estás navegando como invitado', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.teal.shade800, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('Inicia sesión para acceder a funciones personalizadas y registrar tus servicios.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.teal.shade800)),
              ]),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(Routes.login),
              icon: const Icon(Icons.login),
              label: const Text('Iniciar sesión'),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.teal.shade700, side: BorderSide(color: Colors.teal.shade300)),
            )
          ],
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [Colors.teal.shade600, Colors.teal.shade400], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [BoxShadow(color: Colors.teal.shade200.withOpacity(0.4), blurRadius: 12, offset: Offset(0, 6))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bienvenido a', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
                const SizedBox(height: 4),
                Text('UruAPPan', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('Servicios municipales al alcance de tu mano', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.search),
                      label: const Text('Buscar trámites'),
                      onPressed: () => Navigator.of(context).pushNamed(Routes.tramites),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.teal.shade700),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pushNamed(Routes.banners),
                      child: const Text('Ver anuncios'),
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.white24)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.location_city, size: 64, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _TopBanners extends StatelessWidget {
  final _repo = BannerRepository();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxWidth > 800 ? 220.0 : 140.0;
      return SizedBox(
        height: height,
        child: StreamBuilder<List<BannerModel>>(
          stream: _repo.streamAllWithFallback(),
          builder: (context, snap) {
            final items = snap.data ?? [];
            if (items.isEmpty) return Center(child: Text('No hay anuncios'));
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final b = items[i];
                return InkWell(
                  onTap: () async {
                    if (b.targetUrl.isNotEmpty) {
                      final uri = Uri.tryParse(b.targetUrl);
                      if (uri != null) await launchUrl(uri);
                    }
                  },
                  child: Container(
                    width: constraints.maxWidth > 800 ? 420 : 320,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.grey.shade100),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: b.imageUrl.isNotEmpty
                          ? Image.network(b.imageUrl, fit: BoxFit.cover, width: double.infinity, height: height)
                          : Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(b.title, style: Theme.of(context).textTheme.titleMedium),
                                  const SizedBox(height: 6),
                                  Text(b.premium ? 'Patrocinado • ${b.planName}' : 'Anuncio', style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                            ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }
}

class _Section {
  final String title;
  final String description;
  final String route;
  final IconData icon;
  const _Section({required this.title, required this.description, required this.route, required this.icon});
}
