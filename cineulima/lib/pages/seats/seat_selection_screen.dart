import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'candy_selection_screen.dart';
import 'package:cineulima/models/entities/seat.dart';

class SeatSelectionScreen extends StatefulWidget {
  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<Seat> leftSeats = List.generate(32, (index) => Seat(id: 'L$index', status: 'not_selected'));
  List<Seat> middleSeats = List.generate(40, (index) => Seat(id: 'M$index', status: 'not_selected'));
  List<Seat> rightSeats = List.generate(32, (index) => Seat(id: 'R$index', status: 'not_selected'));

  double get totalPrice => selectedSeats * 20; // $20 per seat
  int get selectedSeats => [leftSeats, middleSeats, rightSeats].expand((x) => x).where((seat) => seat.status == 'selected').length;
  int get availableSeats => [leftSeats, middleSeats, rightSeats].expand((x) => x).where((seat) => seat.status == 'not_selected').length;

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
            Text('Not Selected')
          ],
        ),
        Column(
          children: [
            Image.asset('assets/images/seat_selected.png', width: 40, height: 40),
            Text('Selected')
          ],
        ),
        Column(
          children: [
            Image.asset('assets/images/seat_occupied.png', width: 40, height: 40),
            Text('Occupied')
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Your Seats"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Text("Cinema Venue Placeholder"),
                  Text("Show Time Placeholder"),
                  Text("Cinema Address Placeholder"),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(child: buildSeatGrid(leftSeats, 8)),
                SizedBox(width: 35),
                Expanded(child: buildSeatGrid(middleSeats, 8)),
                SizedBox(width: 35),
                Expanded(child: buildSeatGrid(rightSeats, 8)),
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
