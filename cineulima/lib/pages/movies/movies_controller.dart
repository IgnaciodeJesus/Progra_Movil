import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/constants.dart';
import '../../models/entities/Pelicula.dart';

class MoviesController extends GetxController {

  TextEditingController filtro = TextEditingController();

  List<Pelicula> filteredPeliculas = [];
  @override
  void onInit() {
    filteredPeliculas.assignAll(PELICULAS);
    super.onInit();
  }

  void filtrarPelicula(String filtro) {
    if (filtro.isEmpty) {
      filteredPeliculas.assignAll(PELICULAS);
    } else {
      filteredPeliculas.clear();
      filteredPeliculas.addAll(PELICULAS.where((pelicula) =>
          pelicula.titulo.toLowerCase().contains(filtro.toLowerCase())));
    }

    update();
  }

}
