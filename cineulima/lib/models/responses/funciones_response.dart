import 'dart:convert';

FuncionesResponse funcionesResponseFromJson(String str) =>
    FuncionesResponse.fromJson(json.decode(str));

String funcionesResponseToJson(FuncionesResponse data) =>
    json.encode(data.toJson());

class FuncionesResponse {
  int funcionId;
  int peliculaId;
  int salaId;
  DateTime fechaHora;
  String peliculaTitulo;
  String salaNombre;
  String salaDireccion;

  FuncionesResponse({
    required this.funcionId,
    required this.peliculaId,
    required this.salaId,
    required this.fechaHora,
    required this.peliculaTitulo,
    required this.salaNombre,
    required this.salaDireccion,
  });

  factory FuncionesResponse.fromJson(Map<String, dynamic> json) =>
      FuncionesResponse(
        funcionId: json["funcion_id"],
        peliculaId: json["pelicula_id"],
        salaId: json["sala_id"],
        fechaHora: DateTime.parse(json["fecha_hora"]),
        peliculaTitulo: json["pelicula_titulo"],
        salaNombre: json["sala_nombre"],
        salaDireccion: json["sala_direccion"],
      );

  Map<String, dynamic> toJson() => {
        "funcion_id": funcionId,
        "pelicula_id": peliculaId,
        "sala_id": salaId,
        "fecha_hora": fechaHora.toIso8601String(),
        "pelicula_titulo": peliculaTitulo,
        "sala_nombre": salaNombre,
        "sala_direccion": salaDireccion,
      };
}
