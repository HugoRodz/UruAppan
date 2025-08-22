import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class _Medico {
  final String nombre;
  final String tipo;
  final String direccion;
  final String telefono;
  final String horario;
  final List<String> servicios;
  final String? especialidad;

  const _Medico({
    required this.nombre,
    required this.tipo,
    required this.direccion,
    required this.telefono,
    required this.horario,
    required this.servicios,
    this.especialidad,
  });
}

class MedicosScreen extends StatefulWidget {
  @override
  _MedicosScreenState createState() => _MedicosScreenState();
}

class _MedicosScreenState extends State<MedicosScreen> {
  String _searchQuery = '';
  
  final List<_Medico> medicos = const [
    _Medico(
      nombre: 'Hospital General de Uruapan',
      tipo: 'Hospital',
      direccion: 'Av. Lázaro Cárdenas #500, Centro',
      telefono: '(452) 523-4567',
      horario: 'Urgencias 24/7',
      especialidad: 'Hospital público de especialidades',
      servicios: ['Urgencias', 'Cirugía General', 'Pediatría', 'Ginecología', 'Traumatología', 'Laboratorio'],
    ),
    _Medico(
      nombre: 'Hospital de la Mujer',
      tipo: 'Hospital',
      direccion: 'Calle Emiliano Zapata #892, Col. Revolución',
      telefono: '(452) 524-8901',
      horario: 'Lunes a Domingo 24 hrs',
      especialidad: 'Ginecología y Obstetricia',
      servicios: ['Maternidad', 'Ginecología', 'Neonatología', 'Planificación familiar'],
    ),
    _Medico(
      nombre: 'Centro de Salud La Magdalena',
      tipo: 'Centro de Salud',
      direccion: 'Calle Morelos #234, Col. La Magdalena',
      telefono: '(452) 524-1890',
      horario: 'Lunes a Viernes 8:00 AM - 4:00 PM',
      especialidad: 'Medicina preventiva',
      servicios: ['Consulta General', 'Vacunación', 'Control prenatal', 'Programa del niño sano'],
    ),
    _Medico(
      nombre: 'Clínica Familiar ISSSTE',
      tipo: 'Clínica',
      direccion: 'Av. Revolución #890, Centro',
      telefono: '(452) 525-3456',
      horario: 'Lunes a Viernes 7:00 AM - 8:00 PM',
      especialidad: 'Medicina familiar',
      servicios: ['Medicina General', 'Odontología', 'Laboratorio', 'Rayos X'],
    ),
    _Medico(
      nombre: 'Cruz Roja Mexicana',
      tipo: 'Institución de Emergencia',
      direccion: 'Av. Benito Juárez #1245',
      telefono: '(452) 523-7890',
      horario: 'Emergencias 24/7',
      especialidad: 'Servicios de emergencia',
      servicios: ['Ambulancias', 'Primeros auxilios', 'Emergencias', 'Capacitación'],
    ),
    _Medico(
      nombre: 'Centro de Salud San José',
      tipo: 'Centro de Salud',
      direccion: 'Col. San José Obrero, Calle Principal s/n',
      telefono: '(452) 526-1234',
      horario: 'Lunes a Viernes 8:00 AM - 3:00 PM',
      especialidad: 'Atención primaria',
      servicios: ['Consulta General', 'Curaciones', 'Inyecciones', 'Toma de signos vitales'],
    ),
  ];

  List<_Medico> get medicosFiltered {
    if (_searchQuery.isEmpty) return medicos;
    return medicos.where((medico) =>
      medico.nombre.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      medico.servicios.any((servicio) => 
        servicio.toLowerCase().contains(_searchQuery.toLowerCase())) ||
      medico.especialidad?.toLowerCase().contains(_searchQuery.toLowerCase()) == true
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Servicios Médicos',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar servicios médicos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                if (_searchQuery.isEmpty) ...[
                  Card(
                    color: Colors.red.shade50,
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(Icons.emergency, color: Colors.red, size: 48),
                          const SizedBox(height: 12),
                          Text(
                            'Números de Emergencia',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildEmergencyNumber('Emergencias General', '911'),
                          _buildEmergencyNumber('Cruz Roja', '(452) 523-7890'),
                          _buildEmergencyNumber('Bomberos', '911'),
                          _buildEmergencyNumber('Hospital General', '(452) 523-4567'),
                        ],
                      ),
                    ),
                  ),
                ],
                ...medicosFiltered.map((medico) => Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: _getTipoColor(medico.tipo),
                      child: Icon(
                        _getTipoIcon(medico.tipo),
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      medico.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(medico.tipo),
                        if (medico.especialidad != null)
                          Text(
                            medico.especialidad!,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(Icons.location_on, 'Dirección', medico.direccion),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.phone, 'Teléfono', medico.telefono),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.access_time, 'Horario', medico.horario),
                            const SizedBox(height: 12),
                            Text(
                              'Servicios disponibles:',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: medico.servicios.map((servicio) => Chip(
                                label: Text(
                                  servicio,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                backgroundColor: _getTipoColor(medico.tipo).withAlpha((0.1 * 255).round()),
                              )).toList(),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // Implementar llamada
                                    },
                                    icon: const Icon(Icons.phone),
                                    label: const Text('Llamar'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      // Implementar navegación
                                    },
                                    icon: const Icon(Icons.directions),
                                    label: const Text('Llegar'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
                if (medicosFiltered.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          'No se encontraron servicios médicos',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Intenta con otros términos de búsqueda',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyNumber(String label, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          SelectableText(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(value),
            ],
          ),
        ),
      ],
    );
  }

  Color _getTipoColor(String tipo) {
    switch (tipo) {
      case 'Hospital':
        return Colors.red;
      case 'Centro de Salud':
        return Colors.green;
      case 'Clínica':
        return Colors.blue;
      case 'Institución de Emergencia':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getTipoIcon(String tipo) {
    switch (tipo) {
      case 'Hospital':
        return Icons.local_hospital;
      case 'Centro de Salud':
        return Icons.medical_services;
      case 'Clínica':
        return Icons.healing;
      case 'Institución de Emergencia':
        return Icons.emergency;
      default:
        return Icons.medical_information;
    }
  }
}