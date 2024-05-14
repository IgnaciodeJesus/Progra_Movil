import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'movies_controller.dart';
import 'package:cineulima/pages/movinfo/movinfo_page.dart';

class MoviesPage extends StatelessWidget {
  MoviesController control = Get.put(MoviesController());

  MoviesPage({super.key});


  Widget _buildBody(BuildContext context) {
    final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight - 124) / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left:15.0),
          child: TextField(
            controller: control.filtro,
            decoration: InputDecoration(
                hintText: 'Buscar película por título',
                hintStyle: GoogleFonts.itim(textStyle: const TextStyle(fontSize: 18)),
                border: InputBorder.none
            ),
            style: GoogleFonts.itim(textStyle: const TextStyle(fontSize: 18)),
            onChanged: (value) => control.filtrarPelicula(value),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: context.isPortrait ? itemWidth / itemHeight : (itemWidth / 2) / (itemHeight) ,
            children: control.filteredPeliculas.map((p) {
              return GestureDetector(
                onTap: () {
                  // Navigate to the new page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovinfoPage(p:p)),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Image.network(
                    p.imagenUrl,
                    fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
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
