import 'package:flutter/material.dart';
import '../services/oficio_repository.dart';
import '../models/oficio.dart';
import 'oficio_form.dart';
import 'oficios_admin_screen.dart';

class OficiosScreen extends StatelessWidget {
  final _repo = OficioRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oficios / Trabajos'),
        actions: [
          IconButton(
            icon: Icon(Icons.admin_panel_settings),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => OficiosAdminScreen())),
          )
        ],
      ),
      body: StreamBuilder<List<Oficio>>(
        stream: _repo.streamAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          final items = snapshot.data?.where((o) => o.publicado).toList() ?? [];
          if (items.isEmpty) return Center(child: Text('No hay oficios publicados'));
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final oficio = items[i];
              return ListTile(
                title: Text(oficio.nombre),
                subtitle: Text(oficio.empresa + '\n' + oficio.domicilio),
                isThreeLine: true,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => OficioForm())),
      ),
    );
  }
}
