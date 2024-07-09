import 'dart:convert';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';
import '../models/entities/Sala.dart';

class SalaService {
  Future<List<Sala>> fetchSalas() async {
    String url = "${BASE_URL}salas";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((sala) => Sala.fromJson(sala)).toList();
      } else {
        throw Exception('Failed to load salas');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
