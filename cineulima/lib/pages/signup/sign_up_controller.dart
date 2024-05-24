import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cineulima/models/entities/Usuario.dart';
import 'package:cineulima/configs/constants.dart';

class SignUpController extends GetxController {
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController dniController;
  late TextEditingController correoController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  var nombre = ''.obs;
  var apellido = ''.obs;
  var dni = ''.obs;
  var correo = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nombreController = TextEditingController();
    apellidoController = TextEditingController();
    dniController = TextEditingController();
    correoController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nombre.value="";
    apellido.value="";
    dni.value="";
    correo.value="";
    password.value="";
    confirmPassword.value="";
  }

  @override
  void onClose() {
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
      id: USUARIOS.length + 1,
      nombre: nombre.value,
      apellido: apellido.value,
      dni: dni.value,
      correo: correo.value,
      password: password.value,
      fotoPerfil: '',
    );

    // Agregar el nuevo usuario a la lista observable de usuarios
    USUARIOS.add(nuevoUsuario);

    Get.defaultDialog(
      title: "Registro Exitoso",
      middleText: "¡Te has registrado correctamente!",
      textConfirm: "Aceptar",
      onConfirm: () {
        Get.back();
        Get.toNamed('/login');
      },
    );

    // Limpiar los campos de entrada
    nombreController.clear();
    apellidoController.clear();
    dniController.clear();
    correoController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
