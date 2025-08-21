import 'package:flutter/material.dart';
import '../services/oficio_repository.dart';
import '../models/oficio.dart';

class OficiosAdminScreen extends StatelessWidget {
  final _repo = OficioRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin: Ofícios pendientes')),
      body: StreamBuilder<List<Oficio>>(
        stream: _repo.streamAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          final items = snapshot.data?.where((o) => !o.publicado).toList() ?? [];
          if (items.isEmpty) return Center(child: Text('No hay oficios pendientes'));
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final oficio = items[i];
              return ListTile(
                title: Text(oficio.nombre),
                subtitle: Text(oficio.descripcion),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () async {
                        await _repo.updatePublication(oficio.id, true);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Publicado')));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _repo.delete(oficio.id);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Eliminado')));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
