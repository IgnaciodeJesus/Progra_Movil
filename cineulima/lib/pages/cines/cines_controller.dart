import 'package:get/get.dart';
import '../../configs/constants.dart';
import '../../models/entities/Sala.dart'; // Asegúrate de importar tu modelo Sala aquí

class CinesController extends GetxController {

  RxList<Sala> filteredSalas = RxList(); // Lista para mostrar en la UI

  @override
  void onInit() {
    filteredSalas.assignAll(SALAS); // Asigna todas las salas a la lista filtrada al iniciar.
    super.onInit();
  }

  void filtrarSala(String filtro) {
    if (filtro.isEmpty) {
      filteredSalas.assignAll(SALAS);
    } else {
      filteredSalas.value = SALAS.where((sala) =>
              sala.nombre.toLowerCase().contains(filtro.toLowerCase()))
          .toList();
    }
    // El método update() no es necesario si usas RxList y los widgets observan los cambios.
  }
}
