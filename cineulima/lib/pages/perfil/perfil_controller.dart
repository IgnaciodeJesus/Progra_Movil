import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../configs/constants.dart';
import '../../models/entities/Usuario.dart';
import '../../models/entities/Pelicula.dart';
import '../../models/entities/Sala.dart';

class PerfilController extends GetxController { 
  Rx<Usuario> usuario = Rx<Usuario>(Usuario.empty());
  
  Usuario? getUsuarioPorId(int id) =>
    USUARIOS.firstWhereOrNull((usuario) => usuario.id == id);

  Pelicula? getPeliculaPorId(int id) =>
      PELICULAS.firstWhereOrNull((pelicula) => pelicula.id == id);

  Sala? getSalaPorId(int id) => 
    SALAS.firstWhereOrNull((sala) => sala.id == id);

  String getPeliculaImagenUrl(int id) {
    return getPeliculaPorId(id)?.imagenUrl ?? "https://via.placeholder.com/150";
  }

  String getPeliculaNombre(int id) {
    return getPeliculaPorId(id)?.titulo ?? "Película no encontrada";
  }

  String getSalaNombre(int id) {
    return getSalaPorId(id)?.nombre ?? "Sala no encontrada";
  }

  final ImagePicker _picker = ImagePicker();

  // Método para actualizar la foto de perfil del usuario
  void actualizarFotoPerfil() async {
    final XFile? imagen = await _picker.pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      // Actualiza el usuario de forma reactiva.
      usuario.value = usuario.value.copyWith(fotoPerfil: imagen.path);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Opcional: Cargar datos adicionales o realizar configuraciones iniciales.
  }
}
