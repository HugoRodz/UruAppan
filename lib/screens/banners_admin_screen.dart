import 'package:flutter/material.dart';
import '../services/banner_repository.dart';
import '../models/banner_model.dart';

class BannersAdminScreen extends StatefulWidget {
  @override
  _BannersAdminScreenState createState() => _BannersAdminScreenState();
}

class _BannersAdminScreenState extends State<BannersAdminScreen> {
  final _repo = BannerRepository();

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
                subtitle: Text(b.premium ? 'Premium' : 'Gratis'),
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
    showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: Text('Nuevo banner'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _titleC, decoration: InputDecoration(labelText: 'Título')),
            TextField(controller: _urlC, decoration: InputDecoration(labelText: 'Image URL')),
            Row(children: [Text('Premium'), Spacer(), Switch(value: _premium, onChanged: (v) { _premium = v; setState((){}); })]),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar')),
          ElevatedButton(onPressed: () async {
            final b = BannerModel(title: _titleC.text, imageUrl: _urlC.text, premium: _premium);
            await _repo.add(b);
            Navigator.of(context).pop();
          }, child: Text('Crear'))
        ],
      );
    });
  }
}
