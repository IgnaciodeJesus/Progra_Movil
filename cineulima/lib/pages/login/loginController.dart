import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:cineulima/pages/home/home_page.dart';
import '../../configs/constants.dart';
import '../../models/entities/Usuario.dart';
import '../recover/recoverPage.dart';
import '../signup/SignUpPage.dart';

class LoginController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxString message = 'primer mensaje'.obs;
  var messageColor = Colors.white.obs;

  /*List<Usuario> usuarios = [
     Usuario(
      id: 1,
      nombre: "Juan",
      apellido: "Pérez",
      dni: "12345678",
      correo: "juan.perez@example.com",
      password: "securepassword123",
      fotoPerfil: "",
      ),
    ];*/

  void login(BuildContext context) {
    print('hola desde el controlador');
    print(userController.text);
    print(passController.text);
    String user = userController.text;
    String password = passController.text;
    bool found = false;
    Usuario userLogged = Usuario.empty();


    for (Usuario u in USUARIOS) {
      print('1 ++++++++++++++++++++');
      print(user);
      print(password);
      print(u);
      if (u.dni == user && u.password == password) {
        found = true;
        userLogged = u;
      }
    }

    if (found) {
      print('usuario correcto');
      message.value = 'Usuario correcto';
      messageColor.value = Colors.green;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  usuarioLogged: userLogged,
                )),
      );
      } else {
      print('error: usuario incorrecto');
      message.value = 'Usuario incorrecto';
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
      MaterialPageRoute(builder: (context) => RecoverPage()),
    );
  }
}
