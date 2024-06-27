import 'dart:convert';

import 'package:cineulima/models/responses/home_page_response.dart';
import 'package:cineulima/models/responses/peliculas_home_response.dart';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';

class PeliculasService {
  Future<List<PeliculasHomeResponse>> fetchHomePage() async {
    String url = "${BASE_URL}peliculas";
    List<PeliculasHomeResponse> homeResults = [];

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedBody = json.decode(response.body);
        decodedBody.forEach((element) {
          homeResults.add(PeliculasHomeResponse.fromJson(element));
        });
      } else if (response.statusCode == 404) {
        throw Exception('No se encontraron resultados');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
    return homeResults;
  }
}
