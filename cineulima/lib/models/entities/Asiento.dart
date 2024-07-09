class Asiento {
  int id;
  String fila;
  int columna;
  String status; // 'selected', 'not_selected', 'occupied'

  Asiento({
    required this.id,
    required this.fila,
    required this.columna,
    this.status = 'not_se, required String statuslected',
  });

  factory Asiento.fromJson(Map<String, dynamic> json) => Asiento(
        id: json["id"],
        fila: json["fila"],
        columna: json["columna"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fila": fila,
        "columna": columna,
      };
}
