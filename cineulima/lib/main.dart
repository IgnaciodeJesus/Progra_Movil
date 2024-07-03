import 'package:cineulima/pages/recover/password_recovery_page.dart';
import 'package:cineulima/pages/signup/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cineulima/pages/login/loginPage.dart'; // Importa la página de inicio de sesión

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cine Ulima',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(name: '/recover', page: () => PasswordRecoveryPage()),

        GetPage(
            name: '/login',
            page: () =>
                LoginPage()), // Define la ruta a la página de inicio de sesión
      ],
    );
  }
}
