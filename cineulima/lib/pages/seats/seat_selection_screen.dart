import 'package:cineulima/Widgets/AppBar.dart';
import 'package:cineulima/models/entities/Funcion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../configs/constants.dart';
import '../../models/entities/Pelicula.dart';
import '../../models/entities/Sala.dart';
import 'candy_selection_screen.dart';
import 'package:cineulima/models/entities/seat.dart';

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

  _SeatSelectionScreenState(this.funcion);

  @override
  void initState() {
    super.initState();
    funcion = widget.funcion;
    pelicula = PELICULAS.firstWhere((p) => p.id == funcion.peliculaId);
    sala = SALAS.firstWhere((s) => s.id == funcion.salaId);
  }
  List<Seat> leftSeats = List.generate(32, (index) => Seat(id: 'L$index', status: 'not_selected'));
  List<Seat> middleSeats = List.generate(40, (index) => Seat(id: 'M$index', status: 'not_selected'));
  List<Seat> rightSeats = List.generate(32, (index) => Seat(id: 'R$index', status: 'not_selected'));

  double get totalPrice => selectedSeats * 20; // $20 per seat
  //int get selectedSeats => [leftSeats, middleSeats, rightSeats].expand((x) => x).where((seat) => seat.status == 'selected').length;
  //int get availableSeats => [leftSeats, middleSeats, rightSeats].expand((x) => x).where((seat) => seat.status == 'not_selected').length;
  int get selectedSeats => middleSeats.where((seat) => seat.status == 'selected').length;
  int get availableSeats => middleSeats.where((seat) => seat.status == 'not_selected').length;


  Widget buildSeatGrid(List<Seat> seats, int crossAxisCount) {
    double seatSize = 60.0;
    double spacing = 2.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: seats.length,
      itemBuilder: (context, index) {
        Seat seat = seats[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              seat.status = seat.status == 'not_selected' ? 'selected' : 'not_selected';
            });
          },
          child: Image.asset(getImageForStatus(seat.status), width: seatSize, height: seatSize),
        );
      },
    );
  }

  Widget buildSeatLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Image.asset('assets/images/seat_not_selected.png', width: 40, height: 40),
            Text('Disponible')
          ],
        ),
        Column(
          children: [
            Image.asset('assets/images/seat_selected.png', width: 40, height: 40),
            Text('Seleccionado')
          ],
        ),
        Column(
          children: [
            Image.asset('assets/images/seat_occupied.png', width: 40, height: 40),
            Text('No disponible')
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Asientos', context, false, true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Text(pelicula.titulo, style: GoogleFonts.inter(textStyle:const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                  ))),
                  Text(sala.nombre, style: GoogleFonts.inter(textStyle:const TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ))),
                  Text(funcion.fechahora.toString(), style: GoogleFonts.inter(textStyle:const TextStyle(
                    color: Colors.black87,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ))),
                ],
              ),
            ),
            Row(
              children: [
                //Expanded(child: buildSeatGrid(leftSeats, 8)),
                //SizedBox(width: 35),
                Expanded(child: buildSeatGrid(middleSeats, 8)),
                //SizedBox(width: 35),
                //Expanded(child: buildSeatGrid(rightSeats, 8)),
              ],
            ),
            SizedBox(height: 20),
            buildSeatLegend(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.asset('assets/images/cinema_screen_reversed.png', height: 125, width: 1000),
            ),
            Text('Selected Seats: $selectedSeats'),
            Text('Available Seats: $availableSeats'),
            Text('Total Price: \$$totalPrice'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CandySalesScreen(
                        seatTotal: totalPrice,
                      ),
                    ),
                  );
                },
                child: Text('Buy Selected Seats'),
              ),
            ),
          ],
        ),
      ),
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
