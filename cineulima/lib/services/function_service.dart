import 'dart:convert';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';
import '../models/responses/funciones_response.dart';

class FunctionService {
  Future<List<FuncionesResponse>> fetchFunctionsByMovieId(int movieId) async {
    String url = "${BASE_URL}funciones?pelicula_id=$movieId";
    List<FuncionesResponse> functions = [];

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedBody = json.decode(response.body);
        decodedBody.forEach((element) {
          functions.add(FuncionesResponse.fromJson(element));
        });
      } else if (response.statusCode == 404) {
        throw Exception('No se encontraron funciones para esta película');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
    return functions;
  }

  Future<List<FuncionesResponse>> fetchFunctionsBySalaId(int salaId) async {
    String url = "${BASE_URL}funciones?sala_id=$salaId";
    List<FuncionesResponse> functions = [];

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedBody = json.decode(response.body);
        decodedBody.forEach((element) {
          functions.add(FuncionesResponse.fromJson(element));
        });
      } else if (response.statusCode == 404) {
        throw Exception('No se encontraron funciones para esta sala');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
    return functions;
  }
}
