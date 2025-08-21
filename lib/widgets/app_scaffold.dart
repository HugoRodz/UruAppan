import 'package:flutter/material.dart';
import '../routes.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final String title;

  const AppScaffold({Key? key, required this.child, this.title = 'UruAPPan'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset('WhatsApp Image 2025-08-21 at 01.35.45.jpeg', height: 36, width: 36, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Text(title),
          ],
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade600, Colors.teal.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset('WhatsApp Image 2025-08-21 at 01.35.45.jpeg', height: 56, width: 56, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('UruAPPan', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Gobierno de Uruapan', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () => Navigator.of(context).pushNamed(Routes.home),
              ),
              ListTile(
                leading: const Icon(Icons.account_balance),
                title: const Text('Trámites'),
                onTap: () => Navigator.of(context).pushNamed(Routes.tramites),
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Banners'),
                onTap: () => Navigator.of(context).pushNamed(Routes.banners),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Versión 0.1', style: Theme.of(context).textTheme.bodySmall),
              )
            ],
          ),
        ),
      ),
      body: child,
    );
  }
}
