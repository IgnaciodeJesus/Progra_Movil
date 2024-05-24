import 'package:cineulima/Widgets/AppBar.dart';
import 'package:cineulima/models/entities/Funcion.dart';
import 'package:cineulima/pages/seats/seat_selection_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../configs/constants.dart';
import '../../models/entities/Pelicula.dart';
import '../../models/entities/Sala.dart';
import 'candy_selection_screen.dart';
import 'package:cineulima/models/entities/seat.dart';
import 'package:get/get.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Funcion funcion;

  SeatSelectionScreen({required this.funcion});

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState(funcion);
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  Funcion funcion;
  late Pelicula pelicula;
  late Sala sala;

  SeatSelectionController controller = Get.put(SeatSelectionController());
  _SeatSelectionScreenState(this.funcion);

  @override
  void initState() {
    super.initState();
    funcion = widget.funcion;
    pelicula = PELICULAS.firstWhere((p) => p.id == funcion.peliculaId);
    sala = SALAS.firstWhere((s) => s.id == funcion.salaId);
  }

  List<Seat> leftSeats =
      List.generate(10, (index) => Seat(id: 'L$index', status: 'not_selected'));
  List<Seat> middleSeats =
      List.generate(40, (index) => Seat(id: 'M$index', status: 'not_selected'));
  List<Seat> rightSeats =
      List.generate(10, (index) => Seat(id: 'R$index', status: 'not_selected'));

  double get totalPrice => selectedSeats * 20; // $20 per seat
  //int get selectedSeats => [leftSeats, middleSeats, rightSeats].expand((x) => x).where((seat) => seat.status == 'selected').length;
  //int get availableSeats => [leftSeats, middleSeats, rightSeats].expand((x) => x).where((seat) => seat.status == 'not_selected').length;
  int get selectedSeats =>
      middleSeats.where((seat) => seat.status == 'selected').length;
  int get availableSeats =>
      middleSeats.where((seat) => seat.status == 'not_selected').length;

  Widget buildSeatGrid(List<Seat> seats, int crossAxisCount) {
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
        Seat seat = seats[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              seat.status =
                  seat.status == 'not_selected' ? 'selected' : 'not_selected';
            });
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
                    fontWeight: FontWeight.w500,
                  )))
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
                    fontWeight: FontWeight.w500,
                  )))
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
                    fontWeight: FontWeight.w500,
                  )))
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
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Text(pelicula.titulo,
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w900,
                            ))),
                        Text(sala.nombre,
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ))),
                        Text(funcion.fechahora.toString(),
                            style: GoogleFonts.itim(
                                textStyle: const TextStyle(
                              color: Colors.black87,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ))),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      /*SizedBox(width: 20),
                      Expanded(child: buildSeatGrid(leftSeats, 2)),*/
                      SizedBox(width: 20),
                      Expanded(child: buildSeatGrid(middleSeats, 8)),
                      SizedBox(width: 20),
                      /*Expanded(child: buildSeatGrid(rightSeats, 2)),
                      SizedBox(width: 20),*/
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Image.asset(
                        'assets/images/cinema_screen_reversed.png',
                        height: 125,
                        width: 1000),
                  ),
                  Text('Asientos Seleccionados: $selectedSeats',
                      style: GoogleFonts.itim(
                          textStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ))),
                  Text('Asientos Disponibles: $availableSeats',
                      style: GoogleFonts.itim(
                          textStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ))),
                  Text('Precio Total: \S/.$totalPrice',
                      style: GoogleFonts.itim(
                          textStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ))),
                  SizedBox(height: 20),
                  buildSeatLegend(),
                  SizedBox(height: 20),
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
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
                            selectedSeats, context, totalPrice, funcion);
                      })),
            ],
          ),
        ));
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
