import 'package:get/get.dart';
import '../../configs/constants.dart';
import '../../models/entities/Usuario.dart';
import '../../models/entities/Funcion.dart';
import '../../models/entities/Pelicula.dart';
import '../../models/entities/Sala.dart';

class PerfilController extends GetxController {

  Usuario get usuario => USUARIOS.first;

  Pelicula? getPeliculaPorId(int id) =>
      PELICULAS.firstWhereOrNull((pelicula) => pelicula.id == id);

  Sala? getSalaPorId(int id) => SALAS.firstWhereOrNull((sala) => sala.id == id);

  String getPeliculaImagenUrl(int id) {
    return getPeliculaPorId(id)?.imagenUrl ?? "https://via.placeholder.com/150";
  }

  String getPeliculaNombre(int id) {
    return getPeliculaPorId(id)?.titulo ?? "Película no encontrada";
  }

  String getSalaNombre(int id) {
    return getSalaPorId(id)?.nombre ?? "Sala no encontrada";
  }
}
