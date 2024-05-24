import 'dart:convert';

import 'package:cineulima/pages/login/LoginPage.dart';
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

class PerfilController extends GetxController {
  Rx<Usuario> usuario = Rx<Usuario>(Usuario.empty());
  Rx<List<Entrada>> entradas = Rx<List<Entrada>>([]);

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedUser = prefs.getString('logged_user');
    print(loggedUser ?? 'No hay usuario logueado');
    if (loggedUser != null) {
      usuario.value = Usuario.fromJson(jsonDecode(loggedUser));
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
    getEntradas();
  }
}
