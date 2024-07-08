import 'dart:convert';
import 'dart:io';
import 'package:cineulima/pages/login/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/constants.dart';
import '../../models/entities/Entrada.dart';
import '../../models/entities/Funcion.dart';
import '../../models/entities/Usuario.dart';
import '../../models/entities/Pelicula.dart';
import '../../models/entities/Sala.dart';
import '../../services/usuario_service.dart';

class PerfilController extends GetxController {
  Rx<Usuario> usuario = Rx<Usuario>(Usuario.empty());
  Rx<List<Entrada>> entradas = Rx<List<Entrada>>([]);

  final UsuarioService _usuarioService = UsuarioService();
  final ImagePicker _picker = ImagePicker();

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedUser = prefs.getString('logged_user');
    print(loggedUser ?? 'No hay usuario logueado');
    if (loggedUser != null) {
      var userId = Usuario.fromJson(jsonDecode(loggedUser)).id;

      // Utiliza el servicio para obtener los datos del usuario
      Usuario? fetchedUser = await _usuarioService.fetchUsuarioById(userId);
      if (fetchedUser != null) {
        print('Fetched user: $fetchedUser');
        usuario.value = fetchedUser;
      } else {
        print('Error: Usuario no encontrado');
      }
    }
  }

  void getEntradas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedUser = prefs.getString('logged_user');
    usuario.value = Usuario.fromJson(jsonDecode(loggedUser!));
    entradas.value = List<Entrada>.from(
        ENTRADAS.where((entrada) => entrada.usuarioId == usuario.value.id));
  }

  Funcion getFuncion(Entrada entrada) {
    return FUNCIONES.firstWhere((f) => f.id == entrada.funcionId);
  }

  Pelicula getPelicula(Entrada entrada) {
    return PELICULAS.firstWhere((p) => p.id == getFuncion(entrada).peliculaId);
  }

  Sala getSala(Entrada entrada) {
    return SALAS.firstWhere((s) => s.id == getFuncion(entrada).salaId);
  }

  String getPeliculaImagenUrl(Entrada entrada) {
    return getPelicula(entrada)?.imagenUrl ?? "https://via.placeholder.com/150";
  }

  String getPeliculaNombre(Entrada entrada) {
    return getPelicula(entrada)?.titulo ?? "Película no encontrada";
  }

  String getSalaNombre(Entrada entrada) {
    return getSala(entrada)?.nombre ?? "Sala no encontrada";
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
      var userId = Usuario.fromJson(jsonDecode(loggedUser)).id;

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
    getEntradas();
  }
}
