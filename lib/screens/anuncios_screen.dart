import 'package:flutter/material.dart';
import 'anuncios_admin_screen.dart';

class AnunciosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anuncios municipales'), actions: [IconButton(icon: Icon(Icons.admin_panel_settings), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AnunciosAdminScreen())))]),
      body: Center(child: Text('Sección editable por administradores municipales')),
    );
  }
}
