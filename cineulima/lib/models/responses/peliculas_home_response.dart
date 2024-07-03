import 'dart:convert';
import 'package:intl/intl.dart';
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
    return PeliculasInfoResponse(
      id: json['id'] as int? ?? 0,
      titulo: json['titulo'] as String? ?? '',
      sinopsis: json['sinopsis'] as String? ?? '',
      imagenUrl: json['imagen_url'] as String? ?? '',
      trailerUrl: json['trailer_url'] as String? ?? '',
      actores: List<String>.from(json['actores']?? []),
      generos: List<String>.from(json['generos']?? []),
      funciones: (json['funciones'] as List<dynamic>?)
          ?.map((item) => FuncionesInfoResponse.fromJson(item as Map<String, dynamic>))
          .toList()?? [],
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
  String generosToString() {
    String generosString = "";
    for (int i = 0; i < generos.length; i++) {
      generosString += generos[i];
      if (i < generos.length - 1) {
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

  FuncionesInfoResponse({
    required this.id,
    required this.nombre_sala,
    required this.fecha
  });

  factory FuncionesInfoResponse.fromJson(Map<String, dynamic> json) {
    return FuncionesInfoResponse(
      id: json["id"] as int? ?? 0,
      nombre_sala: json['nombre_sala'] as String? ?? '',
      fecha: DateFormat('dd/MM/yyyy HH:mm:ss').parse(json['fecha'] as String? ?? '')
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
