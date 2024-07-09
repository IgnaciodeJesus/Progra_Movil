import 'package:cineulima/pages/seats/candy_selection_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../models/entities/Asiento.dart';
import '../../services/seat_service.dart';
import '../../models/responses/funciones_response.dart';

class SeatSelectionController extends GetxController {
  RxList<Asiento> seats = <Asiento>[].obs;
  RxList<Asiento> selectedSeats = <Asiento>[].obs;
  final double seatPrice = 20.0;
  final SeatService seatService = SeatService();

  Future<void> fetchSeatsByFunctionId(int functionId) async {
    var seatsData = await seatService.fetchSeatsByFunctionId(functionId);
    List<Map<String, dynamic>> occupiedSeats =
        List<Map<String, dynamic>>.from(seatsData['no_disponibles']);
    List<Map<String, dynamic>> availableSeats =
        List<Map<String, dynamic>>.from(seatsData['disponibles']);

    seats.assignAll(List.generate(50, (index) {
      String fila = String.fromCharCode(65 + (index ~/ 10));
      int columna = (index % 10) + 1;
      Map<String, dynamic>? seatData = availableSeats.firstWhereOrNull(
        (seat) => seat['fila'] == fila && seat['columna'] == columna,
      );

      if (seatData == null) {
        seatData = occupiedSeats.firstWhereOrNull(
          (seat) => seat['fila'] == fila && seat['columna'] == columna,
        );
      }

      bool isOccupied = seatData != null &&
          occupiedSeats
              .any((occupiedSeat) => occupiedSeat['id'] == seatData!['id']);
      return Asiento(
        id: seatData?['id'] ?? -1,
        fila: fila,
        columna: columna,
        status: isOccupied ? 'occupied' : 'not_selected',
      );
    }));
  }

  void toggleSeatSelection(Asiento seat) {
    print('Seat ID: ${seat.id}');
    if (seat.status == 'not_selected') {
      seat.status = 'selected';
      selectedSeats.add(seat);
    } else if (seat.status == 'selected') {
      seat.status = 'not_selected';
      selectedSeats.remove(seat);
    }
    seats.refresh();
  }

  double get totalPrice => selectedSeats.length * seatPrice;

  void selectSeats(int selectedSeatsCount, BuildContext context,
      double totalPrice, FuncionesResponse funcion) {
    if (selectedSeatsCount < 1) {
      Get.snackbar('Error', 'Seleccione al menos un asiento');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CandySalesScreen(
            seatTotal: totalPrice,
            funcion: funcion,
          ),
        ),
      );
    }
  }
}
