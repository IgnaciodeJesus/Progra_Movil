import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    // Aquí puedes implementar la lógica para recuperar la contraseña
    // Por ejemplo, enviar un correo electrónico con un enlace para restablecer la contraseña
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
  }
}
