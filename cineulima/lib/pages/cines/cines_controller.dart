import 'package:get/get.dart';
import '../../models/entities/Sala.dart'; // Asegúrate de importar tu modelo Sala aquí

class CinesController extends GetxController {
  final RxList<Sala> salas = RxList([
    Sala(
        id: 1,
        nombre: "Pabellón F1",
        direccion: "Av. Club Golf los Incas 148, Surco",
        imagenUrl:
            "https://www.ulima.edu.pe/sites/default/files/styles/600x300/public/news/img/ulima_centro-de-bienestar-universitario_600x300.jpg?itok=zkCb_0DH"),
    Sala(
        id: 2,
        nombre: "Pabellón L2",
        direccion: "Jirón Cruz del Sur 15023, Surco",
        imagenUrl:
            "https://www.ulima.edu.pe/sites/default/files/styles/600x300/public/page/gallery/w.jpg?itok=vDEBxmDd"),
    Sala(
        id: 3,
        nombre: "Pabellón N",
        direccion: "Av. Club Golf los Incas 148, Surco",
        imagenUrl:
            "https://www.ulima.edu.pe/sites/default/files/styles/600x300/public/news/img/ulima_para_ranking_1.jpg?itok=-duMkaQJ"),
    Sala(
        id: 4,
        nombre: "Pabellón I1",
        direccion: "Av. Club Golf los Incas 148, Surco",
        imagenUrl:
            "https://www.ulima.edu.pe/sites/default/files/styles/600x300/public/news/img/_mg_5142-hdr-edit.jpg?itok=fFkits6x"),
    Sala(
        id: 5,
        nombre: "Pabellón C",
        direccion: "Manuel Olguin 125, Surco",
        imagenUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLpWX9PZ1tqqFVXWpQin9SvUo1Z-jhOPcEGGURbaDupA&s"),
    Sala(
        id: 6,
        nombre: "Pabellón O1",
        direccion: "Av. Club Golf los Incas 148, Surco",
        imagenUrl:
            "https://orientacion.universia.edu.pe/imgs2011/imagenes/2-2020_10_-2020_10_16_161111@2x.jpg"),
    Sala(
        id: 7,
        nombre: "Pre de Lima",
        direccion: "Las Palmas 199, La Molina",
        imagenUrl:
            "https://orientacion.universia.edu.pe/imgs2011/imagenes/1-2019_10_-2020_10_16_161044@2x.jpg"),
  ]);

  RxList<Sala> filteredSalas = RxList(); // Lista para mostrar en la UI

  @override
  void onInit() {
    filteredSalas.assignAll(
        salas); // Asigna todas las salas a la lista filtrada al iniciar.
    super.onInit();
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
    // El método update() no es necesario si usas RxList y los widgets observan los cambios.
  }
}
