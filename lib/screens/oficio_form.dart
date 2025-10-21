import 'package:flutter/material.dart';
import '../models/oficio.dart';
import '../services/oficio_repository.dart';

class OficioForm extends StatefulWidget {
  final String? initialCategory;

  const OficioForm({Key? key, this.initialCategory}) : super(key: key);

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
  'categoria': '',
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
  categoria: _data['categoria'] ?? '',
  publicado: false,
    );

    try {
      final id = await _repo.add(oficio);
      // verify the document exists (small retry loop)
      Oficio? saved;
      const int maxRetries = 5;
      int attempts = 0;
      while (attempts < maxRetries && saved == null) {
        await Future.delayed(Duration(milliseconds: 300));
        saved = await _repo.getById(id);
        attempts++;
      }

      if (saved != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registro enviado correctamente (id: $id)')));
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registro enviado, pero no se encontró en la base de datos (intentar más tarde)')));
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al guardar: $e')));
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // initialize category if provided
    if ((widget.initialCategory ?? '').isNotEmpty && _data['categoria'] == '') {
      _data['categoria'] = widget.initialCategory!;
    }
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
              const SizedBox(height: 12),
              // Category dropdown
              _CategoryDropdown(
                initialValue: _data['categoria'],
                onSaved: (v) => _data['categoria'] = v ?? '',
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

class _CategoryDropdown extends FormField<String> {
  _CategoryDropdown({String? initialValue, FormFieldSetter<String>? onSaved})
      : super(
          initialValue: initialValue ?? '',
          onSaved: onSaved,
          builder: (state) {
            final categories = [
              '',
              'Construcción y Remodelación',
              'Servicios Domésticos',
              'Transporte y Mudanzas',
              'Tecnología y Soporte',
              'Salud y Bienestar',
            ];
            return InputDecorator(
              decoration: InputDecoration(labelText: 'Categoría'),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: state.value == '' ? null : state.value,
                  isExpanded: true,
                  hint: Text('Selecciona una categoría'),
                  items: categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c == '' ? 'Sin especificar' : c)))
                      .toList(),
                  onChanged: (v) => state.didChange(v ?? ''),
                ),
              ),
            );
          },
        );
}
