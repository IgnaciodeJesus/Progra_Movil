import 'dart:convert';

import '../../configs/constants.dart';
import 'Funcion.dart';
import 'Pelicula.dart';
import 'Sala.dart';

Entrada entradaFromJson(String str) => Entrada.fromJson(json.decode(str));

String entradaToJson(Entrada data) => json.encode(data.toJson());

class Entrada {
  String id;
  int funcionId;
  int usuarioId;

  Entrada({
    required this.id,
    required this.funcionId,
    required this.usuarioId,
  });

  factory Entrada.fromJson(Map<String, dynamic> json) => Entrada(
        id: json["id"],
        funcionId: json["funcion_id"],
        usuarioId: json["usuario_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "funcion_id": funcionId,
        "usuario_id": usuarioId,
      };
}
