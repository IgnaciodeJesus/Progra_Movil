import 'package:cineulima/models/responses/peliculas_home_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../configs/constants.dart';
import '../../models/entities/Pelicula.dart';
import '../../services/peliculas_service.dart';

class MoviesController extends GetxController {
  TextEditingController filtro = TextEditingController();
  PeliculasService peliculasService = PeliculasService();
  RxList<PeliculasHomeResponse> peliculas = RxList();
  RxList<PeliculasHomeResponse> filteredPeliculas = RxList();

  void filtrarPelicula(String filtro) {
    if (filtro.isEmpty) {
      filteredPeliculas.assignAll(peliculas);
    } else {
      filteredPeliculas.assignAll(peliculas
          .where((pelicula) =>
              pelicula.titulo.toLowerCase().contains(filtro.toLowerCase()))
          .toList());
    }
    refresh();
  }

  Future<void> fetchPeliculas() async {
    List<PeliculasHomeResponse>? peliResponse =
        await peliculasService.fetchHomePage();
    if (peliResponse.isNotEmpty) {
      peliculas.value = peliResponse;
      filteredPeliculas.value = peliResponse;
    } else {
      Fluttertoast.showToast(
          msg: "No se encontraron resultados",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
