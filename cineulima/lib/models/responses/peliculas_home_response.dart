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
