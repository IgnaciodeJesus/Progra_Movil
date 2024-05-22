import 'package:cineulima/Widgets/AppBar.dart';
import 'package:cineulima/pages/recover/password_recovery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryPage extends StatelessWidget {
  final PasswordRecoveryController control =
      Get.put(PasswordRecoveryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('', context, false, true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70), // Espacio adicional arriba
              Image.asset(
                'assets/images/logo.png',
                height: 90,
              ),
              SizedBox(height: 30),
              Text(
                'Recuperar Contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFFDE0B4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: control.dniController,
                      onChanged: (value) => control.dni.value = value,
                      decoration: InputDecoration(
                        labelText: 'DNI',
                        prefixIcon: Icon(Icons.person),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      controller: control.correoController,
                      onChanged: (value) => control.correo.value = value,
                      decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        prefixIcon: Icon(Icons.email),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        control.recoverPassword();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFFF26F29),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: Text(
                        'RECUPERAR',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 5)
                  ],
                ),
              ),
              SizedBox(
                  height:
                      50), // Espacio adicional entre el contenedor y el texto
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/signup');
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '¿No tienes una cuenta? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: 'Regístrate',
                          style: TextStyle(
                            color: Color(0xFF0000FF),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30), // Espacio adicional abajo
            ],
          ),
        ),
      ),
    );
  }
}
