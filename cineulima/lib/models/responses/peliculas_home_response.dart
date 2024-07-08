import 'dart:convert';
import '../../configs/constants.dart';
import '../entities/Pelicula.dart';

List<PeliculasHomeResponse> peliculasHomeResponseFromJson(String str) =>
    List<PeliculasHomeResponse>.from(
        json.decode(str).map((x) => PeliculasHomeResponse.fromJson(x)));

String peliculasHomeResponseToJson(List<PeliculasHomeResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PeliculasHomeResponse {
  int id;
  String imagenUrl;
  String titulo;

  PeliculasHomeResponse(
      {required this.id, required this.imagenUrl, required this.titulo});

  factory PeliculasHomeResponse.fromJson(Map<String, dynamic> json) =>
      PeliculasHomeResponse(
          id: json["id"],
          imagenUrl: "${BASE_URL}movies/${json["imagen_url"]}",
          titulo: json["titulo"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "imagen_url": imagenUrl, "titulo": titulo};
}

class PeliculasInfoResponse {
  Pelicula peliculadata;
  List<FuncionesInfoResponse> funciones;

  PeliculasInfoResponse({
    required this.peliculadata,
    required this.funciones,
  });

  factory PeliculasInfoResponse.fromJson(Map<String, dynamic> json) {
    return PeliculasInfoResponse(
      peliculadata: Pelicula.fromJson(json),
      funciones: (json['funciones'] as List<dynamic>?)
              ?.map((item) =>
                  FuncionesInfoResponse.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  static PeliculasInfoResponse empty() {
    return PeliculasInfoResponse(
      peliculadata: Pelicula.empty(),
      funciones: [],
    );
  }

  String generosToString() {
    String generosString = "";
    for (int i = 0; i < peliculadata.generos.length; i++) {
      generosString += peliculadata.generos[i];
      if (i < peliculadata.generos.length - 1) {
        generosString += " - ";
      }
    }
    return generosString;
  }
}

class FuncionesInfoResponse {
  int id;
  String nombre_sala;
  DateTime fecha;

  FuncionesInfoResponse(
      {required this.id, required this.nombre_sala, required this.fecha});

  factory FuncionesInfoResponse.fromJson(Map<String, dynamic> json) {
    return FuncionesInfoResponse(
        id: json["id"],
        nombre_sala: json['nombre_sala'],
        fecha: DateTime.parse(json['time']));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_sala": nombre_sala,
        "time": fecha,
      };

  static FuncionesInfoResponse empty() {
    return FuncionesInfoResponse(id: 0, nombre_sala: "", fecha: DateTime.now());
  }
}
