import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/constants.dart';
import '../../models/entities/Usuario.dart';

class PasswordRecoveryController extends GetxController {
  late TextEditingController dniController;
  late TextEditingController correoController;

  var dni = ''.obs;
  var correo = ''.obs;

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

  void recoverPassword() {
    if (dni.value.isEmpty || correo.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Por favor, complete todos los campos.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Verificar si el DNI y el correo están registrados
    bool usuarioEncontrado = false;

    for (var usuario in USUARIOS) {
      if (usuario.dni == dni.value && usuario.correo == correo.value) {
        usuarioEncontrado = true;
        break;
      }
    }

    if (usuarioEncontrado) {
      // Limpiar los campos de texto después de recuperar la contraseña
      dniController.clear();
      correoController.clear();

      Get.defaultDialog(
        title: "Recuperar Contraseña",
        middleText:
            "Un correo electrónico de restablecimiento de contraseña ha sido enviado a ${correo.value}. Por favor, revisa tu bandeja de entrada y sigue las instrucciones.",
        textConfirm: "Aceptar",
        onConfirm: () {
          Get.back(); // Cerrar el diálogo
          Get.toNamed('/login'); // Navegar a la página de inicio de sesión
        },
      );
    } else {
      Get.snackbar(
        'Error',
        'No se encontró ningún usuario con el DNI y correo electrónico proporcionados.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
