import 'package:flutter/material.dart';
import '../models/oficio.dart';
import '../services/oficio_repository.dart';

class OficioForm extends StatefulWidget {
  @override
  _OficioFormState createState() => _OficioFormState();
}

class _OficioFormState extends State<OficioForm> {
  final _formKey = GlobalKey<FormState>();
  final _repo = OficioRepository();

  final Map<String, String> _data = {
    'nombre': '',
    'empresa': '',
    'domicilio': '',
    'telefono': '',
    'email': '',
    'horarios': '',
    'descripcion': '',
  };

  bool _submitting = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _submitting = true);
    final oficio = Oficio(
      nombre: _data['nombre']!,
      empresa: _data['empresa']!,
      domicilio: _data['domicilio']!,
      telefono: _data['telefono']!,
      email: _data['email']!,
      horarios: _data['horarios']!,
      descripcion: _data['descripcion']!,
      publicado: false,
    );

    try {
      await _repo.add(oficio);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registro enviado. Pendiente de validación por admin')));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar oficio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre *'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                onSaved: (v) => _data['nombre'] = v ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Empresa'),
                onSaved: (v) => _data['empresa'] = v ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Domicilio'),
                onSaved: (v) => _data['domicilio'] = v ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                onSaved: (v) => _data['telefono'] = v ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+');
                  return emailRegex.hasMatch(v) ? null : 'Email inválido';
                },
                onSaved: (v) => _data['email'] = v ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Horarios'),
                onSaved: (v) => _data['horarios'] = v ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 4,
                onSaved: (v) => _data['descripcion'] = v ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitting ? null : _submit,
                child: _submitting ? CircularProgressIndicator(color: Colors.white) : Text('Enviar registro'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
