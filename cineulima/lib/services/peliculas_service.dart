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

  Future<PeliculasInfoResponse> fetchPeliculasPage(int id) async {
    String url = "${BASE_URL}peliculas";
    PeliculasInfoResponse peliculaResults = PeliculasInfoResponse.empty();

    var queryParams = {
      'id': id.toString(), // Aquí se convierte el id a String
    };
    var uri = Uri.parse(url).replace(queryParameters: queryParams);
    print(uri);
    try {
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var rpt = json.decode(response.body);
        peliculaResults = PeliculasInfoResponse.fromJson(rpt);
        print('aqui imprimeee');
        print(peliculaResults.toJson());
      } else if (response.statusCode == 404) {
        throw Exception('No se encontraron resultados');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
    print('se imprime?');
    return peliculaResults;
  }
}
