import 'dart:convert';

Sala salasFromJson(String str) => Sala.fromJson(json.decode(str));

String salasToJson(Sala data) => json.encode(data.toJson());

class Sala {
  int id;
  String nombre;
  String direccion;
  String imagenUrl;

  Sala({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.imagenUrl,
  });

  factory Sala.fromJson(Map<String, dynamic> json) => Sala(
    id: json["id"],
    nombre: json["nombre"],
    direccion: json["direccion"],
    imagenUrl: json["imagen_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "direccion": direccion,
    "imagen_url": imagenUrl,
  };

  @override
  String toString() {
    return 'Salas{id: $id, nombre: $nombre, direccion: $direccion, imagenUrl: $imagenUrl}';
  }
}