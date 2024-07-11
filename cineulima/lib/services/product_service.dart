import 'dart:convert';
import 'package:http/http.dart' as http;
import '../configs/constants.dart';
import '../models/entities/Producto.dart';

class ProductService {
  Future<List<Producto>> fetchProducts() async {
    String url = "${BASE_URL}productos";
    List<Producto> products = [];

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        products = productoFromJson(response.body);
      } else {
        throw Exception('Error al obtener los productos');
      }
    } catch (e) {
      print('Error no esperado: $e');
    }
    return products;
  }
}
