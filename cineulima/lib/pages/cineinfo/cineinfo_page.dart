import 'package:cineulima/Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../configs/constants.dart';
import 'cineinfo_controller.dart';
import '../seats/seat_selection_screen.dart';

class CineInfoPage extends StatelessWidget {
  final CineInfoController controller = Get.put(CineInfoController());

  CineInfoPage({Key? key, required int salaId}) : super(key: key) {
    controller.fetchFuncionesBySalaId(salaId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar('Cines', context, false, true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.funciones.isEmpty) {
          return Center(child: Text("No hay funciones disponibles"));
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCinemaImage(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Comprar entradas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0000FF),
                  ),
                ),
              ),
              _buildDateSelector(),
              _buildFuncionesList(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCinemaImage(BuildContext context) {
    final sala = controller.funciones.first.salaNombre;
    final direccion = controller.funciones.first.salaDireccion;
    final imagenUrl = controller.funciones.first.salaImagenUrl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network('${BASE_URL}cinemas/$imagenUrl',
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            sala,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            direccion,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    final fechas = controller.getFechasFiltradas();
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: fechas.length,
        itemBuilder: (context, index) {
          final fecha = fechas[index];
          return GestureDetector(
            onTap: () {
              controller.selectedDate.value = fecha['value'];
              controller.updateFuncionesFiltradas(fecha['value']);
            },
            child: Container(
              width: 80,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: controller.selectedDate.value == fecha['value']
                    ? Colors.orange
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fecha['diaSemana'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: controller.selectedDate.value == fecha['value']
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    fecha['diaMes'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: controller.selectedDate.value == fecha['value']
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Text(
                    fecha['mes'],
                    style: TextStyle(
                      color: controller.selectedDate.value == fecha['value']
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFuncionesList(BuildContext context) {
    return Obx(() {
      return Column(
        children: controller.funcionesFiltradas.map((funcionData) {
          final pelicula = controller.funciones.firstWhere(
              (element) => element.peliculaId == funcionData['peliculaId']);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pelicula.peliculaTitulo,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...funcionData['funciones'].map<Widget>((funcion) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(funcion['horario']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeatSelectionScreen(
                                  funcion: funcion["funcion"])),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      );
    });
  }
}
