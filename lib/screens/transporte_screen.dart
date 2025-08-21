import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class _Ruta {
  final String numero;
  final String nombre;
  final String precio;
  final String frecuencia;
  final String horario;
  final List<String> paradas;
  final String descripcion;

  const _Ruta({
    required this.numero,
    required this.nombre,
    required this.precio,
    required this.frecuencia,
    required this.horario,
    required this.paradas,
    required this.descripcion,
  });
}

class TransporteScreen extends StatelessWidget {
  final List<_Ruta> rutas = const [
    _Ruta(
      numero: '1',
      nombre: 'Centro-Revolución',
      precio: '\$12.00',
      frecuencia: 'Cada 15 minutos',
      horario: '5:30 AM - 10:30 PM',
      descripcion: 'Conecta el centro histórico con la colonia Revolución',
      paradas: ['Plaza de Armas', 'Mercado de Antojitos', 'Hospital General', 'Col. Revolución'],
    ),
    _Ruta(
      numero: '2',
      nombre: 'Aeropuerto-Universidad',
      precio: '\$15.00',
      frecuencia: 'Cada 20 minutos',
      horario: '6:00 AM - 9:00 PM',
      descripcion: 'Ruta directa del aeropuerto hacia la zona universitaria',
      paradas: ['Aeropuerto', 'La Magdalena', 'Centro', 'Universidad Vasco de Quiroga'],
    ),
    _Ruta(
      numero: '3',
      nombre: 'Periférico Norte',
      precio: '\$10.00',
      frecuencia: 'Cada 10 minutos',
      horario: '5:00 AM - 11:00 PM',
      descripcion: 'Circuito por la zona norte de la ciudad',
      paradas: ['Terminal Norte', 'Walmart', 'IMSS', 'Col. Francisco Villa'],
    ),
    _Ruta(
      numero: '4',
      nombre: 'San José-Centro',
      precio: '\$11.00',
      frecuencia: 'Cada 12 minutos',
      horario: '6:00 AM - 10:00 PM',
      descripcion: 'Desde San José Obrero hasta el centro de la ciudad',
      paradas: ['San José Obrero', 'Soriana', 'Secundaria 2', 'Plaza de Armas'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Transporte Público',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.directions_bus, color: Theme.of(context).primaryColor, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sistema de Transporte Público',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Descuentos: Estudiantes 50% • Adultos mayores 25%',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...rutas.map((ruta) => Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: _getColorByRoute(ruta.numero),
                child: Text(
                  ruta.numero,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                'Ruta ${ruta.nombre}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${ruta.precio} • ${ruta.frecuencia}'),
                  Text(
                    ruta.descripcion,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                ruta.horario,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paradas principales:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      ...ruta.paradas.map((parada) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, 
                                 size: 16, 
                                 color: _getColorByRoute(ruta.numero)),
                            const SizedBox(width: 8),
                            Text(parada),
                          ],
                        ),
                      )),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Chip(
                            label: Text('Precio: ${ruta.precio}'),
                            backgroundColor: Colors.green.shade100,
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            label: Text(ruta.frecuencia),
                            backgroundColor: Colors.blue.shade100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 16),
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.info_outline, 
                       color: Colors.blue.shade700, 
                       size: 32),
                  const SizedBox(height: 8),
                  Text(
                    'Información Adicional',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('• Tarjeta de prepago disponible con 10% de descuento'),
                  const Text('• Horarios pueden variar los domingos y días festivos'),
                  const Text('• Consultas y quejas: (452) 524-RUTA (7882)'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorByRoute(String numero) {
    switch (numero) {
      case '1':
        return Colors.blue;
      case '2':
        return Colors.green;
      case '3':
        return Colors.orange;
      case '4':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}