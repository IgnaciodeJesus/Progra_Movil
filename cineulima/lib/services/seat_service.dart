import 'dart:convert';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';

class SeatService {
  Future<Map<String, dynamic>> fetchSeatsByFunctionId(int functionId) async {
    String url = "${BASE_URL}funciones/$functionId/asientos";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedBody = json.decode(response.body);
        print(
            'Response from server: $decodedBody'); // Imprime el resultado de la consulta

        // Imprime los asientos disponibles
        List disponibles = decodedBody['disponibles'];
        print('Asientos disponibles:');
        for (var asiento in disponibles) {
          print(asiento);
        }

        // Imprime los asientos no disponibles
        List noDisponibles = decodedBody['no_disponibles'];
        print('Asientos no disponibles:');
        for (var asiento in noDisponibles) {
          print(asiento);
        }

        return decodedBody;
      } else {
        throw Exception('Failed to load seats');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
