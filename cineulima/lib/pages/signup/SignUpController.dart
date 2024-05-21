import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cineulima/models/entities/Usuario.dart';

class SignUpController extends GetxController {
  // Definiendo TextEditingController para cada campo
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController dniController;
  late TextEditingController correoController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  // Definiendo observables para los campos
  var nombre = ''.obs;
  var apellido = ''.obs;
  var dni = ''.obs;
  var correo = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Inicializando los TextEditingController
    nombreController = TextEditingController();
    apellidoController = TextEditingController();
    dniController = TextEditingController();
    correoController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    // Descartando los TextEditingController
    nombreController.dispose();
    apellidoController.dispose();
    dniController.dispose();
    correoController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void createAccount() {
    if (nombre.value.isEmpty ||
        apellido.value.isEmpty ||
        dni.value.isEmpty ||
        correo.value.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Por favor, complete todos los campos.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar(
        'Error',
        'Las contraseñas no coinciden.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Usuario nuevoUsuario = Usuario(
      id: 0,
      nombre: nombre.value,
      apellido: apellido.value,
      dni: dni.value,
      correo: correo.value,
      password: password.value,
      fotoPerfil: '',
    );

    // Simulando registro exitoso
    print(nuevoUsuario.toJson());

    // Mostrar diálogo de confirmación
    Get.defaultDialog(
      title: "Registro Exitoso",
      middleText: "¡Te has registrado correctamente!",
      textConfirm: "Aceptar",
      onConfirm: () {
        Get.back(); // Cerrar el diálogo
        Get.toNamed('/login'); // Navegar a la página de login
      },
    );
  }
}
