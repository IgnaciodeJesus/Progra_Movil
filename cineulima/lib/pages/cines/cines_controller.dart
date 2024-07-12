import 'package:get/get.dart';
import '../../models/entities/Sala.dart';
import '../../services/sala_service.dart';

class CinesController extends GetxController {
  var salas = <Sala>[].obs;
  var filteredSalas = <Sala>[].obs;

  Future<List<Sala>> fetchSalas() async {
    try {
      List<Sala> fetchedSalas = await SalaService().fetchSalas();
      return fetchedSalas;
    } catch (e) {
      print("Error fetching salas: $e");
      return [];
    }
  }

  void setSalas(List<Sala> salasList) {
    salas.assignAll(salasList);
    filteredSalas.assignAll(salasList);
  }

  void filtrarSala(String query) {
    if (query.isEmpty) {
      filteredSalas.assignAll(salas);
    } else {
      filteredSalas.assignAll(salas.where(
          (sala) => sala.nombre.toLowerCase().contains(query.toLowerCase())));
    }
  }
}
