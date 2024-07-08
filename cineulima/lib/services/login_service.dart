import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/entities/Usuario.dart';
import '../configs/constants.dart';

class LoginService {
  Future<bool> login(String dni, String password) async {
    final url = Uri.parse('${BASE_URL}user/validate');
    final response = await http.post(
      url,
      body: {'dni': dni, 'password': password},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['message'] == 'Usuario encontrado - Ingreso Exitoso') {
        Usuario userLogged = Usuario(
          id: data['data'],
          nombre: '', // Añade los otros campos necesarios
          apellido: '',
          dni: dni,
          correo: '',
          password: password,
          fotoPerfil: '',
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('logged_user', jsonEncode(userLogged));
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Error al conectar con el servidor');
    }
  }
}
