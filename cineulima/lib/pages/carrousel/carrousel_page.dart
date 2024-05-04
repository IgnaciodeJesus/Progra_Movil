import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/entities/Pelicula.dart';
import 'carrousel_controller.dart';

class CarrouselPage extends StatelessWidget {
  CarrouselPageController control = Get.put(CarrouselPageController());

  Widget _movieInfo(BuildContext context, Pelicula pelicula){
    return Stack(
      children: [
        // Imagen de fondo
        Image.network(
          pelicula.imagenUrl,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        // Contenido superpuesto
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0), Colors.black.withOpacity(1)]
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Título
                Text(
                  pelicula.titulo,
                  style: GoogleFonts.inter(textStyle:const TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.w900,
                  ),)
                ),
                // Géneros
                Text(
                  pelicula.generosToString(),
                  style: GoogleFonts.itim(textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0
                  ))
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: MediaQuery.of(context).size.height, viewportFraction: 1, autoPlay: true),
      items: control.peliculas.map((pelicula) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: _movieInfo(context, pelicula)
            );
          },
        );
      }).toList(),

    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    ));
  }
}
