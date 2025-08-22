import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';
import '../services/profile_repository.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _selectedProfile = 'Ciudadano';
  bool _loading = false;

  final List<String> _profiles = ['Ciudadano', 'Comerciante', 'Administrador'];

  void _setError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      await auth.signInWithEmail(_emailCtrl.text.trim(), _passCtrl.text);
      // save profile selection locally
      final profileSvc = Provider.of<ProfileService>(context, listen: false);
      await profileSvc.setProfile(_selectedProfile);
      // if firebase user present, persist profile to Firestore
      if (auth.currentUser != null) {
        final repo = ProfileRepository();
        await repo.saveProfileForUser(auth.currentUser!.uid, _selectedProfile);
      }
    } catch (e) {
      _setError('Error al iniciar sesión: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      await auth.registerWithEmail(_emailCtrl.text.trim(), _passCtrl.text);
      final profileSvc = Provider.of<ProfileService>(context, listen: false);
      await profileSvc.setProfile(_selectedProfile);
      if (auth.currentUser != null) {
        final repo = ProfileRepository();
        await repo.saveProfileForUser(auth.currentUser!.uid, _selectedProfile);
      }
    } catch (e) {
      _setError('Error al registrar: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedProfile,
                items: _profiles.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (v) => setState(() => _selectedProfile = v ?? _selectedProfile),
                decoration: const InputDecoration(labelText: 'Perfil'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Correo'),
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: (v) => (v == null || v.length < 6) ? 'Min 6 chars' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading ? null : _signIn,
                child: _loading ? const CircularProgressIndicator() : const Text('Iniciar sesión'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _loading ? null : _register,
                child: const Text('Crear cuenta'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                ),
                onPressed: _loading
                    ? null
                    : () async {
                        // allow public access as Ciudadano without registering
                        final profileSvc = Provider.of<ProfileService>(context, listen: false);
                        await profileSvc.setProfile('Ciudadano');
                        Navigator.of(context).pushReplacementNamed(Routes.home);
                      },
                icon: const Icon(Icons.person_outline),
                label: const Text('Entrar como ciudadano (sin registrarse)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
