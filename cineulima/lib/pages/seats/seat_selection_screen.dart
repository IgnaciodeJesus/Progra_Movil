import 'package:cineulima/Widgets/AppBar.dart';
import 'package:cineulima/pages/seats/seat_selection_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../models/entities/Asiento.dart';
import '../../models/responses/funciones_response.dart';
import '../../pages/seats/candy_selection_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final FuncionesResponse funcion;

  SeatSelectionScreen({required this.funcion});

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState(funcion);
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final SeatSelectionController controller = Get.put(SeatSelectionController());
  final FuncionesResponse funcion;

  _SeatSelectionScreenState(this.funcion);

  @override
  void initState() {
    super.initState();
    controller.fetchSeatsByFunctionId(funcion.funcionId);
  }

  Widget buildSeatGrid(List<Asiento> seats, int crossAxisCount) {
    double spacing = 10.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1,
        crossAxisSpacing: spacing / 2,
        mainAxisSpacing: spacing,
      ),
      itemCount: seats.length,
      itemBuilder: (context, index) {
        Asiento seat = seats[index];
        return GestureDetector(
          onTap: () {
            if (seat.status != 'occupied') {
              controller.toggleSeatSelection(seat);
            }
          },
          child: Image.asset(getImageForStatus(seat.status), height: 2),
        );
      },
    );
  }

  Widget buildSeatLegend() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset('assets/images/seat_not_selected.png',
                  width: 30, height: 30),
              Text('Disponible',
                  style: GoogleFonts.itim(
                      textStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500)))
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/seat_selected.png',
                  width: 30, height: 30),
              Text('Seleccionado',
                  style: GoogleFonts.itim(
                      textStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500)))
            ],
          ),
          Column(
            children: [
              Image.asset('assets/images/seat_occupied.png',
                  width: 30, height: 30),
              Text('No disponible',
                  style: GoogleFonts.itim(
                      textStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500)))
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Asientos', context, false, true),
      body: Obx(() {
        return controller.seats.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Text(funcion.peliculaTitulo,
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.w900))),
                              Text(funcion.salaNombre,
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700))),
                              Text(funcion.fechaHora.toString(),
                                  style: GoogleFonts.itim(
                                      textStyle: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500))),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Expanded(
                                child: buildSeatGrid(controller.seats, 10)),
                            SizedBox(width: 20),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Image.asset(
                              'assets/images/cinema_screen_reversed.png',
                              height: 125,
                              width: 1000),
                        ),
                        Text(
                            'Asientos Seleccionados: ${controller.selectedSeats.length}',
                            style: GoogleFonts.itim(
                                textStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500))),
                        Text(
                            'Asientos Disponibles: ${controller.seats.length - controller.selectedSeats.length}',
                            style: GoogleFonts.itim(
                                textStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500))),
                        Text('Precio Total: S/.${controller.totalPrice}',
                            style: GoogleFonts.itim(
                                textStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500))),
                        SizedBox(height: 20),
                        buildSeatLegend(),
                        SizedBox(height: 20),
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            GestureDetector(
                              child: BottomAppBar(
                                height: 50,
                                color: Color(0xFF000C78),
                                child: Container(
                                  color: Colors.transparent,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.zero,
                                  child: Text('Seleccionar asientos',
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              height: 1,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w800))),
                                ),
                              ),
                              onTap: () {
                                controller.selectSeats(
                                    controller.selectedSeats.length,
                                    context,
                                    controller.totalPrice,
                                    widget.funcion);
                              },
                            ),
                          ],
                        )),
                  ],
                ),
              );
      }),
    );
  }

  String getImageForStatus(String status) {
    switch (status) {
      case 'selected':
        return 'assets/images/seat_selected.png';
      case 'occupied':
        return 'assets/images/seat_occupied.png';
      default:
        return 'assets/images/seat_not_selected.png';
    }
  }
}
