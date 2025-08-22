import 'package:flutter/material.dart';
import '../services/banner_repository.dart';
import '../models/banner_model.dart';
import '../services/plan_repository.dart';
import '../models/plan_model.dart';

class BannersAdminScreen extends StatefulWidget {
  @override
  _BannersAdminScreenState createState() => _BannersAdminScreenState();
}

class _BannersAdminScreenState extends State<BannersAdminScreen> {
  final _repo = BannerRepository();
  final _plansRepo = PlanRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin: Banners')),
      body: StreamBuilder<List<BannerModel>>(
        stream: _repo.streamAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          final items = snapshot.data ?? [];
          if (items.isEmpty) return Center(child: Text('No hay banners'));
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final b = items[i];
              return ListTile(
                leading: b.imageUrl.isNotEmpty ? Image.network(b.imageUrl, width: 56, height: 56, fit: BoxFit.cover) : null,
                title: Text(b.title),
                    subtitle: Text(b.premium ? 'Premium • ${b.planName}' : 'Gratis'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                    IconButton(icon: Icon(Icons.delete), onPressed: () async { await _repo.delete(b.id); }),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showCreateDialog(),
      ),
    );
  }

  void _showCreateDialog() {
    final _titleC = TextEditingController();
    final _urlC = TextEditingController();
  bool _premium = false;
  String? _selectedPlanId;
  String? _selectedPlanName;
  final _plansStream = _plansRepo.streamAllWithFallback();
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: Text('Nuevo banner'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _titleC, decoration: InputDecoration(labelText: 'Título')),
            TextField(controller: _urlC, decoration: InputDecoration(labelText: 'Image URL')),
            Row(children: [Text('Premium'), Spacer(), Switch(value: _premium, onChanged: (v) { _premium = v; setState((){}); })]),
            const SizedBox(height: 8),
            StreamBuilder<List<PlanModel>>(
              stream: _plansStream,
              builder: (context, snap) {
                final plans = snap.data ?? [];
                if (plans.isEmpty) return Text('Planes disponibles: (ninguno)');
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Plan asociado (opcional)'),
                  items: plans.map((p) => DropdownMenuItem(value: p.id, child: Text('${p.name} — \$${p.pricePerMonth}/mes'))).toList(),
                  onChanged: (v) {
                    _selectedPlanId = v;
                    _selectedPlanName = plans.firstWhere((p) => p.id == v).name;
                    setState(() {});
                  },
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar')),
          ElevatedButton(onPressed: () async {
            final b = BannerModel(title: _titleC.text, imageUrl: _urlC.text, premium: _premium, planId: _selectedPlanId ?? '', planName: _selectedPlanName ?? '');
            await _repo.add(b);
            Navigator.of(context).pop();
          }, child: Text('Crear'))
        ],
      );
    });
  }
}
