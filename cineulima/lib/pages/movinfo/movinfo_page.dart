import 'package:cineulima/pages/movies/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/entities/Pelicula.dart';
import './movinfo_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovinfoPage extends StatelessWidget {
  final MovinfoController controller = Get.put(MovinfoController());
  final Pelicula p;

  MovinfoPage({Key? key, required this.p}) {
    controller.init(p.trailerUrl);
  }

  Widget _buildBody(BuildContext context) {
    var fechasFiltradas = controller.getFechasFiltradas(p);
    if (fechasFiltradas.length > 0){
      controller.selectedDate.value = fechasFiltradas[0]['value'];
    }
    controller.funcionesFiltradas.value = controller.getFuncionesPorFecha(p, controller.selectedDate.value);
    return SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Video with movie title overlay
        Stack(
          children: [
            // Video player
            YoutubePlayer(
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),
                RemainingDuration(),
              ],
              controller: controller.controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.orange,
              progressColors: const ProgressBarColors(
                playedColor: Colors.orange,
                handleColor: Colors.orangeAccent,
              ),
              onReady: () {
                // Add listener
                controller.controller.addListener(() {});
              },
            ),
            // Movie title overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                  Text(
                    p.titulo,
                    style: GoogleFonts.inter(textStyle:const TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900,
                    ))
                  ),
                  Text(
                    p.generosToString(),
                    style: GoogleFonts.itim(textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0
                    )),
                  ),
                  ]
                )
              ),
            ),
          ],
        ),
        // Movie information
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sinopsis',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF000C78), // Use Color class to specify color from hex
                  fontWeight: FontWeight.bold, // Set text to bold
                ),
              ),
              SizedBox(height: 2),
              Text(
                p.sinopsis,
                style: TextStyle(fontSize: 12.5),
              ),
              SizedBox(height: 20),
              Text(
                'Actores',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF000C78), // Use Color class to specify color from hex
                  fontWeight: FontWeight.bold, // Set text to bold
                ),
              ),
              SizedBox(height: 2), // Espacio entre el texto y la lista de actores
              SizedBox(
                height: 100,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 20),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: (p.actores.length / 2).ceil(), // Calcular la cantidad de filas
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '• ${p.actores[index * 2]}',
                              style: TextStyle(fontSize: 12.5),
                            ),
                          ),
                          SizedBox(width: 8), // Espacio entre los actores
                          Expanded(
                            child: (index * 2 + 1 < p.actores.length)
                                ? Text(
                              '• ${p.actores[index * 2 + 1]}',
                              style: TextStyle(fontSize: 12.5),
                            )
                                : SizedBox(), // En caso de que el número de actores sea impar
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Text(
                fechasFiltradas.length > 0 ? 'Comprar entradas' : 'No hay funciones disponibles para esta película',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF000C78), // Use Color class to specify color from hex
                  fontWeight: FontWeight.bold, // Set text to bold
                ),
                textAlign: fechasFiltradas.length > 0 ? TextAlign.left :TextAlign.center,
              ),
              SizedBox(width: 4),
              Container(
                height: 85,
                child: ListView.builder(
                scrollDirection : Axis.horizontal,
                shrinkWrap: true,
                itemCount: fechasFiltradas.length,
                itemBuilder: (context, index) {
                  var fecha = fechasFiltradas[index];
                  return GestureDetector(
                      onTap: () {
                        controller.selectedDate.value = fecha['value'];
                        controller.funcionesFiltradas.value = controller.getFuncionesPorFecha(p, controller.selectedDate.value);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child : Obx(() => Container(
                          width: 50,
                          padding: EdgeInsets.only(left:5, right:5, top:5),
                          decoration: BoxDecoration(
                          border: Border.all(color: controller.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black26),
                          borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                fecha['diaSemana'],
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: controller.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black45),
                              ),
                              Text(
                                fecha['diaMes'],
                                style: TextStyle(height: 1.2,fontWeight: FontWeight.bold, fontSize: 25, color: controller.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black45),
                              ),
                              Text(
                                fecha['mes'],
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: controller.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black45),
                              ),
                            ],
                          ),
                        )
                      )
                      )
                  );
                    },
                  ),
              ),
              Obx(() => Column(
                children: controller.funcionesFiltradas.value.map((funcion) => Column(
                    children : [
                      Divider(),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${funcion['sala']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: (funcion['funciones'] as List<Map<String, dynamic>>)
                            .map((funcion) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFF000C78))
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.only(top: 5, bottom: 5, right: 20),
                          child: Text(
                            '${funcion['horario']}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF000C78)),
                          ),
                        ))
                            .toList(),
                      )
                    ]
                )).toList(),
              )
              )
            ],
          ),
        ),
      ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.pop(context);

              },
          ),
          titleSpacing: 5,
          title: Text(
            'Peliculas',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0XFFF26F29),
        ),
        body: _buildBody(context),
      ),
    );
  }
}
