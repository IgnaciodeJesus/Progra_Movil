import 'dart:convert';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';
import '../models/entities/Historial.dart';

class HistorialService {
  Future<List<Historial>> fetchHistorialByUserId(int userId) async {
    String url = "${BASE_URL}usuarios/historial/$userId";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedBody = json.decode(utf8.decode(response.bodyBytes));
        print('Response from server: $decodedBody');
        List<Historial> historialList = (decodedBody as List)
            .map((data) => Historial.fromJson(data))
            .toList();
        return historialList;
      } else if (response.statusCode == 404) {
        throw Exception('Historial no encontrado');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
    return [];
  }
}
