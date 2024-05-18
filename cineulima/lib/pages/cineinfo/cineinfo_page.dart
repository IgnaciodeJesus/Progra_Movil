import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/entities/Sala.dart';
import 'cineinfo_controller.dart'; // Asegúrate de que este importe esté correcto
import 'package:google_fonts/google_fonts.dart';

class CineInfoPage extends StatelessWidget {
  final CineInfoController control = Get.put(CineInfoController());
  final Sala sala;

  CineInfoPage({Key? key, required this.sala}) {
    control.init();
  }

  Widget _buildBody(BuildContext context) {

    var fechasFiltradas = control.getFechasFiltradas(sala);
    if (fechasFiltradas.length > 0){
      control.selectedDate.value = fechasFiltradas[0]['value'];
    }
    control.funcionesFiltradas.value = control.getFuncionesPorFecha(sala, control.selectedDate.value);

    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video with movie title overlay
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.black,
                  child: Opacity(opacity: 0.8,
                      child: Image.network(
                    sala.imagenUrl,
                    fit: BoxFit.cover,
                  )),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                          children: [
                            Text(
                                sala.nombre,
                                style: GoogleFonts.inter(textStyle:const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w900,
                                ))
                            ),
                            Text(
                              sala.direccion,
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
                    fechasFiltradas.isNotEmpty ? 'Comprar entradas' : 'No hay funciones disponibles en esta sala',
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
                              control.selectedDate.value = fecha['value'];
                              control.funcionesFiltradas.value = control.getFuncionesPorFecha(sala, control.selectedDate.value);
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child : Obx(() => Container(
                                  width: 50,
                                  padding: EdgeInsets.only(left:5, right:5, top:5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: control.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black26),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        fecha['diaSemana'],
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: control.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black45),
                                      ),
                                      Text(
                                        fecha['diaMes'],
                                        style: TextStyle(height: 1.2,fontWeight: FontWeight.bold, fontSize: 25, color: control.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black45),
                                      ),
                                      Text(
                                        fecha['mes'],
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: control.selectedDate.value == fecha['value'] ? Colors.orange : Colors.black45),
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
                  Obx(() =>
                      Column(
                    children: control.funcionesFiltradas.value.map((funcion) => Padding(padding:EdgeInsets.symmetric(horizontal: 12, vertical: 2.5) ,child: Column(
                        children : [
                          Divider(),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left:10, right: 20),
                                child:
                                Image.network(funcion['imagenUrl'], width: 110)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(
                                  '${funcion['pelicula']}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      height: 130,
                                      child:
                                      Wrap(
                                      direction: Axis.vertical,
                                      children: List.generate(
                                        funcion['funciones'].length,
                                            (index) {
                                          return buildContainer(funcion['funciones'][index]);
                                        },
                                      )
                                      ),
                                     ),
                                    )],
                              )
                            ],
                          ),
                        ]
                    )),).toList(),
                  )
                  )
                ],
              ),
            ),
          ],
        )
    );
  }

  Container buildContainer(Map<String, dynamic> funcion) {
    return Container(
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
      body: _buildBody(context),
    );
  }
}
