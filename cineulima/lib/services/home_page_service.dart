import 'dart:convert';
import 'package:cineulima/models/responses/home_page_response.dart';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';

class HomePageService {
  Future<List<HomePageResponse>> fetchHomePage() async {
    String url = "${BASE_URL}home";
    List<HomePageResponse> homeResults = [];

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedBody = json.decode(response.body);
        decodedBody.forEach((element) {
          homeResults.add(HomePageResponse.fromJson(element));
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
