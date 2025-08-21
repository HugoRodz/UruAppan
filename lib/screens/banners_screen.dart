import 'package:flutter/material.dart';
import 'banners_admin_screen.dart';

class BannersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Banners'), actions: [IconButton(icon: Icon(Icons.admin_panel_settings), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BannersAdminScreen())))]),
      body: Center(child: Text('Gestión de banners (premium)')),
    );
  }
}
