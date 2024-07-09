import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/entities/Sala.dart';
import '../seats/seat_selection_screen.dart';
import 'cineinfo_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../configs/constants.dart';

class CineInfoPage extends StatelessWidget {
  final CineInfoController controller = Get.put(CineInfoController());
  final Sala sala;

  CineInfoPage({Key? key, required this.sala}) : super(key: key) {
    controller.fetchFuncionesBySalaId(sala.id);
  }

  Widget _buildBody(BuildContext context) {
    var fechasFiltradas = controller.getFechasFiltradas();
    if (fechasFiltradas.isNotEmpty) {
      controller.selectedDate.value = fechasFiltradas[0]['value'];
    }
    controller.updateFuncionesFiltradas(controller.selectedDate.value);

    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.black,
              child: Opacity(
                  opacity: 0.8,
                  child: Image.network(
                    '${BASE_URL}cinemas/${sala.imagenUrl}',
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(children: [
                    Text(sala.nombre,
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w900,
                        ))),
                    Text(
                      sala.direccion,
                      style: GoogleFonts.itim(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 14.0)),
                    ),
                  ])),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fechasFiltradas.isNotEmpty
                    ? 'Comprar entradas'
                    : 'No hay funciones disponibles en esta sala',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF000C78),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: fechasFiltradas.isNotEmpty
                    ? TextAlign.left
                    : TextAlign.center,
              ),
              SizedBox(width: 4),
              Container(
                height: 85,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: fechasFiltradas.length,
                  itemBuilder: (context, index) {
                    var fecha = fechasFiltradas[index];
                    return GestureDetector(
                        onTap: () {
                          controller.selectedDate.value = fecha['value'];
                          controller.updateFuncionesFiltradas(fecha['value']);
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Obx(() => Container(
                                  width: 50,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: controller.selectedDate.value ==
                                                fecha['value']
                                            ? Colors.orange
                                            : Colors.black26),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        fecha['diaSemana'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            color:
                                                controller.selectedDate.value ==
                                                        fecha['value']
                                                    ? Colors.orange
                                                    : Colors.black45),
                                      ),
                                      Text(
                                        fecha['diaMes'],
                                        style: TextStyle(
                                            height: 1.2,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color:
                                                controller.selectedDate.value ==
                                                        fecha['value']
                                                    ? Colors.orange
                                                    : Colors.black45),
                                      ),
                                      Text(
                                        fecha['mes'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            color:
                                                controller.selectedDate.value ==
                                                        fecha['value']
                                                    ? Colors.orange
                                                    : Colors.black45),
                                      ),
                                    ],
                                  ),
                                ))));
                  },
                ),
              ),
              Obx(() => Column(
                    children:
                        controller.funcionesFiltradas.value.map((funcion) {
                      final pelicula = controller.funciones.firstWhere(
                          (element) =>
                              element.peliculaId == funcion['peliculaId']);
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 2.5),
                        child: Column(
                          children: [
                            Divider(),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 20),
                                  child: Image.network(
                                    '${BASE_URL}movies/${pelicula.peliculaImagenUrl}', // Actualizamos para mostrar la imagen de la película
                                    width: 110,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${pelicula.peliculaTitulo}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        height: 130,
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: List.generate(
                                            funcion['funciones'].length,
                                            (index) {
                                              return buildHorario(
                                                  funcion['funciones'][index],
                                                  context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ))
            ],
          ),
        ),
      ],
    ));
  }

  GestureDetector buildHorario(
      Map<String, dynamic> funcion, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SeatSelectionScreen(funcion: funcion["funcion"])),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFF000C78)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
        child: Text(
          '${funcion['horario']}',
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000C78)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 5,
        title: Text(
          'Cines',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: const Color(0XFFF26F29),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.funciones.isEmpty) {
          return Center(child: Text("No hay funciones disponibles"));
        }
        return _buildBody(context);
      }),
    );
  }
}
