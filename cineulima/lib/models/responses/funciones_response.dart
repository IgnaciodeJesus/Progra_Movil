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
  String peliculaImagenUrl; // Añadimos este campo
  String salaNombre;
  String salaDireccion;
  String salaImagenUrl; // Añadimos este campo

  FuncionesResponse({
    required this.funcionId,
    required this.peliculaId,
    required this.salaId,
    required this.fechaHora,
    required this.peliculaTitulo,
    required this.peliculaImagenUrl, // Inicializamos este campo
    required this.salaNombre,
    required this.salaDireccion,
    required this.salaImagenUrl, // Inicializamos este campo
  });

  factory FuncionesResponse.fromJson(Map<String, dynamic> json) =>
      FuncionesResponse(
        funcionId: json["funcion_id"],
        peliculaId: json["pelicula_id"],
        salaId: json["sala_id"],
        fechaHora: DateTime.parse(json["fecha_hora"]),
        peliculaTitulo: json["pelicula_titulo"],
        peliculaImagenUrl: json["pelicula_imagen_url"], // Mapeamos este campo
        salaNombre: json["sala_nombre"],
        salaDireccion: json["sala_direccion"],
        salaImagenUrl: json["sala_imagen_url"], // Mapeamos este campo
      );

  Map<String, dynamic> toJson() => {
        "funcion_id": funcionId,
        "pelicula_id": peliculaId,
        "sala_id": salaId,
        "fecha_hora": fechaHora.toIso8601String(),
        "pelicula_titulo": peliculaTitulo,
        "pelicula_imagen_url": peliculaImagenUrl, // Añadimos este campo
        "sala_nombre": salaNombre,
        "sala_direccion": salaDireccion,
        "sala_imagen_url": salaImagenUrl, // Añadimos este campo
      };
}
