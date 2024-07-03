import 'dart:convert';

Pelicula peliculaFromJson(String str) => Pelicula.fromJson(json.decode(str));

String peliculaToJson(Pelicula data) => json.encode(data.toJson());

class Pelicula {
  int id;
  String titulo;
  String sinopsis;
  String imagenUrl;
  String trailerUrl;
  List<String> actores;
  List<String> generos;

  Pelicula({
    required this.id,
    required this.titulo,
    required this.sinopsis,
    required this.imagenUrl,
    required this.trailerUrl,
    required this.actores,
    required this.generos,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) => Pelicula(
    id: json["id"],
    titulo: json["titulo"],
    sinopsis: json["sinopsis"],
    imagenUrl: json["imagen_url"],
    trailerUrl: json["trailer_url"],
    actores: List<String>.from(json["actores"].map((x) => x)),
    generos: List<String>.from(json["generos"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "titulo": titulo,
    "sinopsis": sinopsis,
    "imagen_url": imagenUrl,
    "trailer_url": trailerUrl,
    "actores": List<dynamic>.from(actores.map((x) => x)),
    "generos": List<dynamic>.from(generos.map((x) => x)),
  };

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

  static Pelicula empty() {
    return Pelicula(
      id: 0,
      titulo: "",
      sinopsis: "",
      imagenUrl: "",
      trailerUrl: "",
      actores: [],
      generos: []
    );
  }

}

