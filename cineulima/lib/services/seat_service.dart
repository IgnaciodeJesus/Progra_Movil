import 'dart:convert';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';

class SeatService {
  Future<Map<String, dynamic>> fetchSeatsByFunctionId(int functionId) async {
    String url = "${BASE_URL}funciones/$functionId/asientos";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load seats');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
