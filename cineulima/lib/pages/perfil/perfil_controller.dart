import 'dart:convert';
import 'dart:io';
import 'package:cineulima/pages/login/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/constants.dart';
import '../../models/entities/Usuario.dart';
import '../../models/entities/Historial.dart';
import '../../services/usuario_service.dart';
import '../../services/historial_service.dart';

class PerfilController extends GetxController {
  Rx<Usuario> usuario = Rx<Usuario>(Usuario.empty());
  Rx<List<Historial>> historial = Rx<List<Historial>>([]);

  final UsuarioService _usuarioService = UsuarioService();
  final HistorialService _historialService = HistorialService();
  final ImagePicker _picker = ImagePicker();

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedUser = prefs.getString('logged_user');
    print(loggedUser ?? 'No hay usuario logueado');
    if (loggedUser != null) {
      var userId =
          Usuario.fromJson(jsonDecode(utf8.decode(loggedUser.runes.toList())))
              .id;

      // Utiliza el servicio para obtener los datos del usuario
      Usuario? fetchedUser = await _usuarioService.fetchUsuarioById(userId);
      if (fetchedUser != null) {
        print('Fetched user: $fetchedUser');
        usuario.value = fetchedUser;
        getHistorial(
            userId); // Obtener el historial después de obtener el usuario
      } else {
        print('Error: Usuario no encontrado');
      }
    }
  }

  void getHistorial(int userId) async {
    List<Historial> fetchedHistorial =
        await _historialService.fetchHistorialByUserId(userId);
    historial.value = fetchedHistorial;
  }

  void logOutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('logged_user');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  // Método para seleccionar y subir la foto de perfil del usuario
  void actualizarFotoPerfil() async {
    final XFile? imagen = await _picker.pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      // Guardar el nombre y apellido actuales
      String nombre = usuario.value.nombre;
      String apellido = usuario.value.apellido;

      // Subir la imagen al servidor
      await subirFotoPerfil(File(imagen.path));

      // Restaurar el nombre y apellido
      usuario.value =
          usuario.value.copyWith(nombre: nombre, apellido: apellido);

      // Recargar el usuario para obtener la nueva imagen
      getUser();
    }
  }

  Future<void> subirFotoPerfil(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedUser = prefs.getString('logged_user');
    if (loggedUser != null) {
      var userId =
          Usuario.fromJson(jsonDecode(utf8.decode(loggedUser.runes.toList())))
              .id;

      // Llamar al servicio para subir la foto de perfil
      Usuario? updatedUser =
          await _usuarioService.uploadProfilePicture(userId, file);
      if (updatedUser != null) {
        usuario.value = updatedUser;

        // Actualizar el usuario en SharedPreferences
        prefs.setString('logged_user', jsonEncode(updatedUser.toJson()));
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUser();
  }
}
