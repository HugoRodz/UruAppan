class Oficio {
  String id;
  String nombre;
  String empresa;
  String domicilio;
  String telefono;
  String email;
  String horarios;
  String descripcion;
  String categoria;
  bool publicado;

  Oficio({
    this.id = '',
    required this.nombre,
    this.empresa = '',
    this.domicilio = '',
    this.telefono = '',
    this.email = '',
    this.horarios = '',
    this.descripcion = '',
  this.categoria = '',
  this.publicado = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'empresa': empresa,
      'domicilio': domicilio,
      'telefono': telefono,
      'email': email,
      'horarios': horarios,
      'descripcion': descripcion,
  'categoria': categoria,
      'publicado': publicado,
    };
  }

  factory Oficio.fromMap(String id, Map<String, dynamic> map) {
    return Oficio(
      id: id,
      nombre: map['nombre'] ?? '',
      empresa: map['empresa'] ?? '',
      domicilio: map['domicilio'] ?? '',
      telefono: map['telefono'] ?? '',
      email: map['email'] ?? '',
      horarios: map['horarios'] ?? '',
      descripcion: map['descripcion'] ?? '',
  categoria: map['categoria'] ?? '',
  publicado: map['publicado'] ?? false,
    );
  }
}
