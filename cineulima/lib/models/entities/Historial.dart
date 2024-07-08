class Historial {
  final int reservaId;
  final Pelicula pelicula;
  final DateTime fechaFuncion;
  final Sala sala;
  final List<Asiento> asientos;
  final List<Producto> productos;
  final double gastoTotal;

  Historial({
    required this.reservaId,
    required this.pelicula,
    required this.fechaFuncion,
    required this.sala,
    required this.asientos,
    required this.productos,
    required this.gastoTotal,
  });

  factory Historial.fromJson(Map<String, dynamic> json) {
    return Historial(
      reservaId: json['reserva_id'],
      pelicula: Pelicula.fromJson(json['pelicula']),
      fechaFuncion: DateTime.parse(json['fecha_funcion']),
      sala: Sala.fromJson(json['sala']),
      asientos:
          (json['asientos'] as List).map((i) => Asiento.fromJson(i)).toList(),
      productos:
          (json['productos'] as List).map((i) => Producto.fromJson(i)).toList(),
      gastoTotal: json['gasto_total'].toDouble(),
    );
  }
}

class Pelicula {
  final String titulo;
  final String imagen;

  Pelicula({
    required this.titulo,
    required this.imagen,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) {
    return Pelicula(
      titulo: json['titulo'],
      imagen: json['imagen'],
    );
  }
}

class Sala {
  final String nombre;
  final String direccion;

  Sala({
    required this.nombre,
    required this.direccion,
  });

  factory Sala.fromJson(Map<String, dynamic> json) {
    return Sala(
      nombre: json['nombre'],
      direccion: json['direccion'],
    );
  }
}

class Asiento {
  final int id;
  final String fila;
  final int columna;

  Asiento({
    required this.id,
    required this.fila,
    required this.columna,
  });

  factory Asiento.fromJson(Map<String, dynamic> json) {
    return Asiento(
      id: json['id'],
      fila: json['fila'],
      columna: json['columna'],
    );
  }
}

class Producto {
  final String nombre;
  final int cantidad;
  final double precio;
  final double total;

  Producto({
    required this.nombre,
    required this.cantidad,
    required this.precio,
    required this.total,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      nombre: json['nombre'],
      cantidad: json['cantidad'],
      precio: json['precio'].toDouble(),
      total: json['total'].toDouble(),
    );
  }
}
