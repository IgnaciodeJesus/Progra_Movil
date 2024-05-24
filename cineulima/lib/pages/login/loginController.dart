import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:cineulima/pages/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/constants.dart';
import '../../models/entities/Usuario.dart';
import '../recover/password_recovery_page.dart';
import '../signup/sign_up_page.dart';

class LoginController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxString message = 'primer mensaje'.obs;
  var messageColor = Colors.white.obs;

  Future<bool> checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedUser = prefs.getString('logged_user');
    print(loggedUser ?? 'No hay usuario logueado');
    if (loggedUser!.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = userController.text;
    String password = passController.text;
    bool found = false;
    Usuario userLogged = Usuario.empty();

    for (Usuario u in USUARIOS) {
      if (u.dni == user && u.password == password) {
        found = true;
        userLogged = u;
      }
      if (found) {
        message.value = 'Usuario correcto';
        messageColor.value = Colors.green;
        await prefs.setString('logged_user', jsonEncode(userLogged));
        print('LOGGED USER:${userLogged.toJson()}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        message.value = 'Usuario incorrecto';
        messageColor.value = Colors.red;
      }
      Future.delayed(Duration(seconds: 5), () {
        message.value = '';
      });
    }
  }

  void goToSignIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  void goToRecover(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PasswordRecoveryPage()),
    );
  }
}
