import 'package:cineulima/pages/recover/password_recovery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoveryPage extends StatelessWidget {
  final PasswordRecoveryController control =
      Get.put(PasswordRecoveryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFF26F29),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30), // Espacio adicional arriba
              Image.asset(
                'assets/images/logo.png',
                height: 100,
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
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFDE0B4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: control.dniController,
                      onChanged: (value) => control.dni.value = value,
                      decoration: InputDecoration(
                        labelText: 'DNI',
                        prefixIcon: Icon(Icons.badge),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: control.correoController,
                      onChanged: (value) => control.correo.value = value,
                      decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        prefixIcon: Icon(Icons.email),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        control.recoverPassword();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFFF26F29),
                        padding: EdgeInsets.symmetric(vertical: 16),
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
                  ],
                ),
              ),
              SizedBox(
                  height:
                      70), // Espacio adicional entre el contenedor y el texto
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
                          text: 'Registrarse',
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
