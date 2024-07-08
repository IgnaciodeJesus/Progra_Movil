import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/constants.dart';
import '../../models/entities/Usuario.dart';
import '../../services/login_service.dart';
import '../recover/password_recovery_page.dart';
import '../signup/sign_up_page.dart';
import '../../pages/home/home_page.dart';

class LoginController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxString message = ''.obs;
  var messageColor = Colors.white.obs;

  Future<bool> checkLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedUser = prefs.getString('logged_user');
    print(loggedUser ?? 'No hay usuario logueado');
    if (loggedUser != null && loggedUser.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> login(BuildContext context) async {
    String user = userController.text;
    String password = passController.text;
    LoginService loginService = LoginService();

    try {
      bool success = await loginService.login(user, password);
      if (success) {
        message.value = 'Usuario correcto';
        messageColor.value = Colors.green;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        message.value = 'Usuario incorrecto';
        messageColor.value = Colors.red;
      }
    } catch (e) {
      message.value = 'Error al conectar con el servidor';
      messageColor.value = Colors.red;
    }

    Future.delayed(Duration(seconds: 5), () {
      message.value = '';
    });
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
