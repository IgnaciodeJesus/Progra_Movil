import 'package:get/get.dart';
import '../../models/entities/Sala.dart';
import '../../services/sala_service.dart';

class CinesController extends GetxController {
  var salas = <Sala>[].obs;
  var filteredSalas = <Sala>[].obs;
  final SalaService salaService = SalaService();

  @override
  void onInit() {
    super.onInit();
    fetchSalas();
  }

  void fetchSalas() async {
    try {
      var fetchedSalas = await salaService.fetchSalas();
      salas.assignAll(fetchedSalas);
      filteredSalas.assignAll(fetchedSalas);
    } catch (e) {
      print('Error fetching salas: $e');
    }
  }

  void filtrarSala(String filtro) {
    if (filtro.isEmpty) {
      filteredSalas.assignAll(salas);
    } else {
      filteredSalas.value = salas
          .where((sala) =>
              sala.nombre.toLowerCase().contains(filtro.toLowerCase()))
          .toList();
    }
  }
}
