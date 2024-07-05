import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart'; // Importa este paquete para acceder al portapapeles
import '../../configs/constants.dart';
import '../../models/entities/Usuario.dart';

class PasswordRecoveryController extends GetxController {
  late TextEditingController dniController;
  late TextEditingController correoController;

  var dni = ''.obs;
  var correo = ''.obs;
  var nuevaContrasena = ''.obs; // Observador para almacenar la nueva contraseña

  @override
  void onInit() {
    super.onInit();
    dniController = TextEditingController();
    correoController = TextEditingController();
    dni.value = "";
    correo.value = "";
  }

  @override
  void onClose() {
    dniController.dispose();
    correoController.dispose();

    super.onClose();
  }

  void recoverPassword() async {
    if (dni.value.isEmpty || correo.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Por favor, complete todos los campos.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.0.138:4567/user/reset'), // Usa tu IP y puerto correctos
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'dni': dni.value,
          'correo': correo.value,
        }),
      );

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        nuevaContrasena.value = responseBody['message'].replaceAll(
            'Contraseña actualizada: ', ''); // Extrae solo la contraseña
        Get.defaultDialog(
          title: "Recuperar Contraseña",
          middleText: "",
          content: Column(
            children: [
              SizedBox(height: 10),
              Text(
                "Has cambiado tu contraseña con éxito : ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                nuevaContrasena.value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: nuevaContrasena.value));
                  Get.snackbar(
                    'Copiado',
                    '¡Contraseña copiada al portapapeles!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                  Get.back(); // Cerrar el diálogo después de copiar
                  Get.toNamed('/login'); // Redirigir al login
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color:
                        Colors.blueAccent, // Color de fondo llamativo del botón
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Copiar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        // Limpiar los campos de texto después de recuperar la contraseña
        dniController.clear();
        correoController.clear();
      } else {
        Get.snackbar(
          'Error',
          responseBody['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Ocurrió un error al intentar recuperar la contraseña.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error inesperado: $e');
    }
  }
}
