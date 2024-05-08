import 'dart:convert';

Funcion funcionFromJson(String str) => Funcion.fromJson(json.decode(str));

String funcionToJson(Funcion data) => json.encode(data.toJson());

class Funcion {
  int id;
  int peliculaId;
  int salaId;
  DateTime fechahora;

  Funcion({
    required this.id,
    required this.peliculaId,
    required this.salaId,
    required this.fechahora,
  });

  factory Funcion.fromJson(Map<String, dynamic> json) => Funcion(
    id: json["id"],
    peliculaId: json["pelicula_id"],
    salaId: json["sala_id"],
    fechahora: json["fechahora"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pelicula_id": peliculaId,
    "sala_id": salaId,
    "fechahora" : fechahora,
  };

  @override
  String toString() {
    return 'Funcion{peliculaId: $peliculaId, salaId: $salaId, fechahora: $fechahora';
  }
}
