import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../models/entities/seat.dart';
import '../../services/seat_service.dart';
import '../../models/responses/funciones_response.dart';
import '../../pages/seats/candy_selection_screen.dart'; // Asegúrate de importar la pantalla de confitería

class SeatSelectionController extends GetxController {
  RxList<Seat> seats = <Seat>[].obs;
  RxList<Seat> selectedSeats = <Seat>[].obs;
  final double seatPrice = 20.0;
  final SeatService seatService =
      SeatService(); // Definir e inicializar seatService

  Future<void> fetchSeatsByFunctionId(int functionId) async {
    var seatsData = await seatService.fetchSeatsByFunctionId(functionId);
    List<int> occupiedSeatIds = List<int>.from(seatsData['no_disponibles']);
    seats.assignAll(List.generate(50, (index) {
      bool isOccupied = occupiedSeatIds.contains(index + 1);
      return Seat(
          id: 'M$index', status: isOccupied ? 'occupied' : 'not_selected');
    }));
  }

  void toggleSeatSelection(Seat seat) {
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
