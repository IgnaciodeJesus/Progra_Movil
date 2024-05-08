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
    controller.selectedDate.value = fechasFiltradas[0]['value'];
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
              controller: controller.controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    p.generosToString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  ]
                )
              ),
            ),
          ],
        ),
        // Movie information
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sinopsis',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF000C78), // Use Color class to specify color from hex
                  fontWeight: FontWeight.bold, // Set text to bold
                ),
              ),
              SizedBox(height: 2),
              Text(
                p.sinopsis,
                style: TextStyle(fontSize: 12.5),
              ),
              SizedBox(height: 8),
              Text(
                'Actores',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF000C78), // Use Color class to specify color from hex
                  fontWeight: FontWeight.bold, // Set text to bold
                ),
              ),
              SizedBox(height: 2), // Espacio entre el texto y la lista de actores
              SizedBox(
                height: 100, // Altura máxima para la lista de actores
                child: ListView.builder(
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
                'Comprar entradas',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF000C78), // Use Color class to specify color from hex
                  fontWeight: FontWeight.bold, // Set text to bold
                ),
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
                        padding: const EdgeInsets.all(8),
                        child : Obx(() => Container(
                          width: 60,
                          decoration: BoxDecoration(
                          border: Border.all(color: controller.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black26),
                          borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                fecha['diaSemana'],
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: controller.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black26),
                              ),
                              Text(
                                fecha['diaMes'],
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: controller.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black26),
                              ),
                              Text(
                                fecha['mes'],
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: controller.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black26),
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
                          style: TextStyle(
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
                            border: Border.all(color: Colors.orange)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          margin: EdgeInsets.only(top: 5, bottom: 5, right: 20),
                          child: Text(
                            '${funcion['horario']}',
                            style: TextStyle(fontSize: 16),
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
          title: Text(
            '<  Peliculas',
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
