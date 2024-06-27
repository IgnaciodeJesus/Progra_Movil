import 'dart:convert';

import 'package:cineulima/configs/constants.dart';

List<HomePageResponse> homePageResponseFromJson(String str) =>
    List<HomePageResponse>.from(
        json.decode(str).map((x) => HomePageResponse.fromJson(x)));

String homePageResponseToJson(List<HomePageResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomePageResponse {
  int id;
  String titulo;
  String imagenUrl;
  List<String> generos;

  HomePageResponse({
    required this.id,
    required this.titulo,
    required this.imagenUrl,
    required this.generos,
  });

  factory HomePageResponse.fromJson(Map<String, dynamic> json) =>
      HomePageResponse(
        id: json["id"],
        titulo: json["titulo"],
        imagenUrl: "${BASE_URL}movies/${json["imagen_url"]}",
        generos: List<String>.from(json["generos"].map((x) => x)),
      );

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

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "imagen_url": imagenUrl,
        "generos": List<dynamic>.from(generos.map((x) => x)),
      };

  HomePageResponse.empty()
      : id = 0,
        titulo = '',
        imagenUrl = '',
        generos = [];

  @override
  String toString() {
    return 'HomePageResponse{titulo: $titulo, imagen_url:$imagenUrl, generos: $generos}';
  }
}
