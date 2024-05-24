import 'dart:convert';

import 'package:cineulima/pages/login/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/constants.dart';
import '../../models/entities/Usuario.dart';
import '../../models/entities/Pelicula.dart';
import '../../models/entities/Sala.dart';

class PerfilController extends GetxController {
  Rx<Usuario> usuario = Rx<Usuario>(Usuario.empty());

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedUser = prefs.getString('logged_user');
    print(loggedUser ?? 'No hay usuario logueado');
    if (loggedUser != null) {
      usuario.value = Usuario.fromJson(jsonDecode(loggedUser));
      print(usuario);
    }
  }

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

  final ImagePicker _picker = ImagePicker();

  void logOutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('logged_user');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  // Método para actualizar la foto de perfil del usuario
  void actualizarFotoPerfil() async {
    final XFile? imagen = await _picker.pickImage(source: ImageSource.gallery);
    if (imagen != null) {
      usuario.value = usuario.value.copyWith(fotoPerfil: imagen.path);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUser();
  }
}
