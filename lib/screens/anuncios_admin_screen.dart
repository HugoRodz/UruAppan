import 'package:flutter/material.dart';
import '../services/anuncio_repository.dart';
import '../models/anuncio.dart';

class AnunciosAdminScreen extends StatelessWidget {
  final _repo = AnuncioRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin: Anuncios')),
      body: StreamBuilder<List<Anuncio>>(
        stream: _repo.streamAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          final items = snapshot.data ?? [];
          if (items.isEmpty) return Center(child: Text('No hay anuncios'));
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final a = items[i];
              return ListTile(
                title: Text(a.title),
                subtitle: Text(a.content),
                trailing: IconButton(icon: Icon(Icons.delete), onPressed: () async { await _repo.delete(a.id); }),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showCreateDialog(context),
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    final _titleC = TextEditingController();
    final _contentC = TextEditingController();
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: Text('Nuevo anuncio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _titleC, decoration: InputDecoration(labelText: 'Título')),
            TextField(controller: _contentC, decoration: InputDecoration(labelText: 'Contenido')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar')),
          ElevatedButton(onPressed: () async {
            final a = Anuncio(title: _titleC.text, content: _contentC.text);
            await _repo.add(a);
            Navigator.of(context).pop();
          }, child: Text('Crear'))
        ],
      );
    });
  }
}
