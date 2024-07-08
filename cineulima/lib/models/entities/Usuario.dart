import 'dart:convert';

Usuario usuarioFromJson(String str) {
  final jsonData = json.decode(str);
  return Usuario.fromJson(jsonData);
}

String usuarioToJson(Usuario data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Usuario {
  int id;
  String nombre;
  String apellido;
  String dni;
  String correo;
  String password;
  String fotoPerfil;

  Usuario.empty()
      : id = 0,
        nombre = '',
        apellido = '',
        dni = '',
        correo = '',
        password = '',
        fotoPerfil = '';

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.correo,
    required this.password,
    required this.fotoPerfil,
  });

  Usuario copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? dni,
    String? correo,
    String? password,
    String? fotoPerfil,
  }) {
    return Usuario(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      dni: dni ?? this.dni,
      correo: correo ?? this.correo,
      password: password ?? this.password,
      fotoPerfil: fotoPerfil ?? this.fotoPerfil,
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    var nombreCompleto = json["nombre completo"]?.split(' ') ?? [''];
    var nombre = nombreCompleto[0];
    var apellido =
        nombreCompleto.length > 1 ? nombreCompleto.sublist(1).join(' ') : '';

    return Usuario(
      id: json["id"] ?? 0, // Default value if id is not present
      nombre: nombre,
      apellido: apellido,
      dni: json["dni"] ?? '',
      correo: json["correo"] ?? '',
      password: json["password"] ?? '',
      fotoPerfil: json["foto_perfil"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "dni": dni,
        "correo": correo,
        "password": password,
        "foto_perfil": fotoPerfil,
      };

  @override
  String toString() {
    return 'Usuario{id: $id, nombre: $nombre, apellido: $apellido, dni: $dni, correo: $correo, password: $password, fotoPerfil: $fotoPerfil}';
  }
}
