import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/entities/Funcion.dart';
import 'candy_selection_screen.dart';

class SeatSelectionController extends GetxController {
  void selectSeats(int selectedSeats, BuildContext context, double totalPrice,
      Funcion funcion) {
    if (selectedSeats < 1) {
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
