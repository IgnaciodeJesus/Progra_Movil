import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';
import '../models/entities/Usuario.dart';

class UsuarioService {
  Future<Usuario?> fetchUsuarioById(int id) async {
    String url = "${BASE_URL}usuarios/$id";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedBody = json.decode(response.body);
        print('Response from server: $decodedBody');
        return Usuario.fromJson(decodedBody);
      } else if (response.statusCode == 404) {
        throw Exception('Usuario no encontrado');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
    return null;
  }

  Future<Usuario?> uploadProfilePicture(int userId, File file) async {
    String url = "${BASE_URL}usuarios/$userId/foto_perfil";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..files
            .add(await http.MultipartFile.fromPath('foto_perfil', file.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        print('Response from server: $jsonResponse');
        return Usuario.fromJson(jsonResponse['usuario']);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
    return null;
  }
}
