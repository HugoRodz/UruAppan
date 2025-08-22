import 'package:flutter/material.dart';
import 'banners_admin_screen.dart';
import '../services/plan_repository.dart';
import '../models/plan_model.dart';

class BannersScreen extends StatelessWidget {
  final _plansRepo = PlanRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Banners'), actions: [IconButton(icon: Icon(Icons.admin_panel_settings), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BannersAdminScreen())))]),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Planes de publicidad (ejemplo)', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Los banners pueden ser gratuitos o asociados a planes pagos. A continuación hay planes de ejemplo que puedes usar para crear banners patrocinados.'),
            const SizedBox(height: 12),
            StreamBuilder<List<PlanModel>>(
              stream: _plansRepo.streamAllWithFallback(),
              builder: (context, snap) {
                final plans = snap.data ?? [];
                if (plans.isEmpty) return Center(child: Text('No hay planes'));
                return Expanded(
                  child: ListView.separated(
                    itemCount: plans.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, i) {
                      final p = plans[i];
                      return ListTile(
                        title: Text(p.name),
                        subtitle: Text(p.description),
                        trailing: Text('\$${p.pricePerMonth.toStringAsFixed(2)}/mes'),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
