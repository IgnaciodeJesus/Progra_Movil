import 'dart:convert';

class FuncionAsiento {
  int id;
  int asientoId;
  int funcionId;

  FuncionAsiento({
    required this.id,
    required this.asientoId,
    required this.funcionId,
  });

  factory FuncionAsiento.fromJson(Map<String, dynamic> json) => FuncionAsiento(
        id: json["id"],
        asientoId: json["asiento_id"],
        funcionId: json["funcion_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "asiento_id": asientoId,
        "funcion_id": funcionId,
      };
}

List<FuncionAsiento> funcionAsientoFromJson(String str) =>
    List<FuncionAsiento>.from(
        json.decode(str).map((x) => FuncionAsiento.fromJson(x)));

String funcionAsientoToJson(List<FuncionAsiento> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
