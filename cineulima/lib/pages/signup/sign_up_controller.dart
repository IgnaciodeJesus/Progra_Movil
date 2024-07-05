import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
    nombre.value = "";
    apellido.value = "";
    dni.value = "";
    correo.value = "";
    password.value = "";
    confirmPassword.value = "";
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

  void createAccount() async {
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
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar(
        'Error',
        'Las contraseñas no coinciden.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.0.138:4567/user/create'), // Usa tu IP y puerto correctos
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nombre': nombre.value,
          'apellido': apellido.value,
          'dni': dni.value,
          'correo': correo.value,
          'password': password.value,
          'foto_perfil': '',
        }),
      );

      if (response.statusCode == 200) {
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
      } else {
        final responseBody = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          responseBody['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Error: ${responseBody['message']}');
      }
    } on http.ClientException catch (e) {
      Get.snackbar(
        'Error de Conexión',
        'No se pudo conectar con el servidor: ${e.message}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(
          'Error de Conexión: No se pudo conectar con el servidor: ${e.message}');
    } catch (e) {
      Get.snackbar(
        'Error inesperado',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error inesperado: $e');
    }
  }
}
