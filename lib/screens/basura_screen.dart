import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class BasuraScreen extends StatelessWidget {
  final List<_Sector> sectores = const [
    _Sector(
      nombre: 'Centro Histórico',
      dias: ['Lunes', 'Miércoles', 'Viernes'],
      horario: '6:00 AM - 10:00 AM',
      tipo: 'Domiciliaria y Comercial',
      colonias: ['Centro', 'Morelos', 'San Juan', 'La Magdalena'],
      color: Colors.blue,
    ),
    _Sector(
      nombre: 'Zona Norte',
      dias: ['Martes', 'Jueves', 'Sábado'],
      horario: '7:00 AM - 11:00 AM',
      tipo: 'Domiciliaria',
      colonias: ['Revolución', 'Gustavo Díaz Ordaz', 'Las Américas', 'INFONAVIT'],
      color: Colors.green,
    ),
    _Sector(
      nombre: 'Zona Sur',
      dias: ['Lunes', 'Miércoles', 'Viernes'],
      horario: '8:00 AM - 12:00 PM',
      tipo: 'Domiciliaria',
      colonias: ['Benito Juárez', 'Lomas de Uruapan', 'Francisco Villa', 'Los Ángeles'],
      color: Colors.orange,
    ),
    _Sector(
      nombre: 'Zona Oriente',
      dias: ['Martes', 'Jueves', 'Sábado'],
      horario: '6:30 AM - 10:30 AM',
      tipo: 'Domiciliaria',
      colonias: ['Emiliano Zapata', 'Nueva Esperanza', 'San Miguel', 'El Tecolote'],
      color: Colors.purple,
    ),
  ];

  final List<_TipoBasura> tiposBasura = const [
    _TipoBasura(
      tipo: 'Orgánica',
      descripcion: 'Restos de comida, cáscaras, jardín',
      color: Colors.green,
      contenedor: 'Verde',
      icono: Icons.eco,
    ),
    _TipoBasura(
      tipo: 'Inorgánica',
      descripcion: 'Plásticos, latas, vidrio limpio',
      color: Colors.blue,
      contenedor: 'Azul',
      icono: Icons.recycling,
    ),
    _TipoBasura(
      tipo: 'Sanitaria',
      descripcion: 'Papel higiénico, pañales, toallas',
      color: Colors.grey,
      contenedor: 'Gris',
      icono: Icons.health_and_safety,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Recolección de Basura',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información general
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.recycling, color: Colors.green.shade600, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Separación de Residuos', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            Text('Ayuda al medio ambiente separando correctamente tus residuos'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tipos de basura
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Tipos de Residuos', style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: tiposBasura.length,
                itemBuilder: (context, index) {
                  final tipo = tiposBasura[index];
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 12),
                    child: Card(
                      color: tipo.color.withAlpha((0.1 * 255).round()),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(tipo.icono, size: 32, color: tipo.color),
                            const SizedBox(height: 8),
                            Text(tipo.tipo, style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text('Contenedor ${tipo.contenedor}', style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text(tipo.descripcion, style: TextStyle(fontSize: 10), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Horarios por Sector', style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 8),

            // Sectores
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: sectores.length,
              itemBuilder: (context, index) {
                final sector = sectores[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: sector.color,
                      child: Icon(Icons.location_on, color: Colors.white),
                    ),
                    title: Text(sector.nombre, style: Theme.of(context).textTheme.titleMedium),
                    subtitle: Text('${sector.dias.join(", ")} • ${sector.horario}'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(Icons.schedule, 'Horario:', sector.horario),
                            _buildInfoRow(Icons.calendar_today, 'Días:', sector.dias.join(', ')),
                            _buildInfoRow(Icons.category, 'Tipo:', sector.tipo),
                            const SizedBox(height: 16),
                            Text('Colonias incluidas:', style: Theme.of(context).textTheme.titleSmall),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: sector.colonias.map((colonia) => Chip(
                                label: Text(colonia, style: TextStyle(fontSize: 12)),
                                backgroundColor: sector.color.withAlpha((0.1 * 255).round()),
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _Sector {
  final String nombre;
  final List<String> dias;
  final String horario;
  final String tipo;
  final List<String> colonias;
  final Color color;

  const _Sector({
    required this.nombre,
    required this.dias,
    required this.horario,
    required this.tipo,
    required this.colonias,
    required this.color,
  });
}

class _TipoBasura {
  final String tipo;
  final String descripcion;
  final Color color;
  final String contenedor;
  final IconData icono;

  const _TipoBasura({
    required this.tipo,
    required this.descripcion,
    required this.color,
    required this.contenedor,
    required this.icono,
  });
}