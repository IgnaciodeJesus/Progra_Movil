import 'dart:convert';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';
import '../models/entities/Entrada.dart';
import '../models/entities/FuncionAsiento.dart';

class ReservaService {
  Future<bool> createReserva(
    int userId,
    int funcionId,
    List<int> asientos,
    List<Map<String, dynamic>> productosSeleccionados,
  ) async {
    String url = "${BASE_URL}reservas";
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'user_id': userId,
          'funcion_id': funcionId,
          'asientos': asientos,
          'productos': productosSeleccionados,
        }),
      );
      if (response.statusCode == 200) {
        // Reserva creada con éxito
        return true;
      } else {
        // Error al crear la reserva
        print('Error al crear la reserva: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return false;
    }
  }
}
