import 'package:flutter/material.dart';
import '../widgets/app_scaffold.dart';

class _TramiteItem {
  final String title;
  final String description;

  const _TramiteItem({required this.title, required this.description});
}

class _Dependencia {
  final String name;
  final bool isPublic;
  final IconData icon;
  final List<_TramiteItem> tramites;

  const _Dependencia({required this.name, required this.isPublic, required this.icon, required this.tramites});
}

const List<_Dependencia> _kDependencias = [
  _Dependencia(
    name: 'CFE',
    isPublic: true,
    icon: Icons.flash_on,
    tramites: [
      _TramiteItem(title: 'Contrato de suministro', description: 'Solicitar nuevo contrato o regularización.'),
      _TramiteItem(title: 'Cambio de titular', description: 'Trámite para cambiar el titular del servicio.'),
      _TramiteItem(title: 'Reporte de falla', description: 'Notificar cortes o fallas en el suministro.'),
    ],
  ),
  _Dependencia(
    name: 'CAPASU',
    isPublic: true,
    icon: Icons.water,
    tramites: [
      _TramiteItem(title: 'Alta de servicio', description: 'Dar de alta suministro de agua potable.'),
      _TramiteItem(title: 'Pago de adeudo', description: 'Consulta y pago de adeudos.'),
    ],
  ),
  _Dependencia(
    name: 'TELMEX',
    isPublic: false,
    icon: Icons.phone,
    tramites: [
      _TramiteItem(title: 'Contratar Internet', description: 'Nuevas contrataciones y paquetes.'),
      _TramiteItem(title: 'Soporte técnico', description: 'Reportar fallas en la línea o internet.'),
    ],
  ),
  _Dependencia(
    name: 'TELCEL',
    isPublic: false,
    icon: Icons.signal_cellular_alt,
    tramites: [
      _TramiteItem(title: 'Nuevo plan', description: 'Contratar o cambiar plan móvil.'),
      _TramiteItem(title: 'Reporte de robo', description: 'Bloquear línea o reportar robo de equipo.'),
    ],
  ),
  _Dependencia(
    name: 'Rentas',
    isPublic: true,
    icon: Icons.receipt_long,
    tramites: [
      _TramiteItem(title: 'Pago de impuesto predial', description: 'Consultar y pagar impuesto predial.'),
      _TramiteItem(title: 'Constancia fiscal', description: 'Solicitar constancias y certificados.'),
    ],
  ),
];

class TramitesScreen extends StatelessWidget {
  const TramitesScreen({Key? key}) : super(key: key);

  void _showTramiteActions(BuildContext context, String dependencia, _TramiteItem tramite) {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$dependencia • ${tramite.title}', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(tramite.description),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        // placeholder: descargar formato
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Descargar formato'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        // placeholder: más info
                      },
                      icon: const Icon(Icons.info_outline),
                      label: const Text('Más info'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorPrimary = Theme.of(context).colorScheme.primary;

    return AppScaffold(
      title: 'Trámites y Dependencias',
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _kDependencias.length,
        itemBuilder: (context, index) {
          final dep = _kDependencias[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: colorPrimary.withAlpha((0.08 * 255).round()),
                child: Icon(dep.icon, color: colorPrimary),
              ),
              title: Row(
                children: [
                  Expanded(child: Text(dep.name, style: const TextStyle(fontWeight: FontWeight.w600))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: dep.isPublic ? Colors.green.shade50 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(dep.isPublic ? 'Público' : 'Privado', style: TextStyle(fontSize: 12, color: dep.isPublic ? Colors.green.shade700 : Colors.grey.shade700)),
                  ),
                ],
              ),
              children: dep.tramites
                  .map((t) => ListTile(
                        title: Text(t.title),
                        subtitle: Text(t.description),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _showTramiteActions(context, dep.name, t),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
