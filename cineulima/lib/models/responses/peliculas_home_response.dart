import 'dart:convert';

import '../../configs/constants.dart';

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
  int id;
  String titulo;
  String sinopsis;
  String imagenUrl;
  String trailerUrl;
  List<String> actores;
  List<String> generos;
  List<FuncionesInfoResponse> funciones;

  PeliculasInfoResponse({
    required this.id,
    required this.titulo,
    required this.imagenUrl,
    required this.actores,
    required this.generos,
    required this.funciones,
    required this.sinopsis,
    required this.trailerUrl,
  });

  factory PeliculasInfoResponse.fromJson(Map<String, dynamic> json) {
    // Convierte las listas de JSON a List<String>
    List<String> parseList(List<dynamic> list) {
      return list.map((item) => item.toString()).toList();
    }

    return PeliculasInfoResponse(
      id: json["id"],
      titulo: json["titulo"],
      sinopsis: json["sinopsis"] ?? '', // si es nulo, devuelve un string vacio
      imagenUrl: "${BASE_URL}movies/${json["imagen_url"]}",
      trailerUrl: json["trailer_url"] ?? '', // si es nulo, devuelve un string vacio
      actores: parseList(json["actores"]),
      generos: parseList(json["generos"]),
      funciones: json["funciones"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "titulo": titulo,
    "sinopsis": sinopsis,
    "imagen_url": imagenUrl,
    "trailer_url": trailerUrl,
    "actores": actores,
    "generos": generos,
    "funciones": funciones,
  };

  static PeliculasInfoResponse empty() {
    return PeliculasInfoResponse(
      id: 0,
      titulo: '',
      sinopsis: '',
      imagenUrl: '',
      trailerUrl: '',
      actores: [],
      generos: [],
      funciones: [],
    );
  }
}

class FuncionesInfoResponse {
  int id;
  String nombre_sala;
  DateTime fecha;

  FuncionesInfoResponse({
    required this.id,
    required this.nombre_sala,
    required this.fecha
  });

  factory FuncionesInfoResponse.fromJson(Map<String, dynamic> json) {
    // Convierte las listas de JSON a List<String>
    List<String> parseList(List<dynamic> list) {
      return list.map((item) => item.toString()).toList();
    }

    return FuncionesInfoResponse(
      id: json["id"],
      nombre_sala: json["nombre_sala"],
      fecha: json["time"]
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre_sala": nombre_sala,
    "fecha": fecha,
  };

  static FuncionesInfoResponse empty() {
    return FuncionesInfoResponse(
      id: 0,
        nombre_sala: "",
        fecha: DateTime.now()
    );
  }
}
