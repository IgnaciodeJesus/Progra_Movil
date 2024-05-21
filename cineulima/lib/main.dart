import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cineulima/pages/signup/SignUpPage.dart';
import 'package:cineulima/pages/login/LoginPage.dart'; // Importa la página de inicio de sesión

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
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage()),
        GetPage(
            name: '/login',
            page: () =>
                LoginPage()), // Define la ruta a la página de inicio de sesión
      ],
    );
  }
}
