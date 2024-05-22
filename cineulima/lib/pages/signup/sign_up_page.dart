import 'package:cineulima/pages/signup/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignUpPage extends StatelessWidget {
  final SignUpController control = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0XFFF26F29), // Cambio de color de fondo
          ),
          body: Container(
            color: Colors.white, // Fondo blanco
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (!isKeyboardVisible) ...[
                            SizedBox(height: 20),
                            Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 100,
                              ),
                            ),
                          ],
                          SizedBox(height: 20),
                          Text(
                            'Registro',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0xFFFDE0B4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _form(context),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '¿Ya tienes una cuenta? ',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/login');
                                },
                                child: Text(
                                  'Iniciar Sesión',
                                  style: TextStyle(
                                    color: Color(0xFF0000FF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField(
          label: 'Nombre',
          icon: Icons.person,
          controller: control.nombreController,
          value: control.nombre,
        ),
        SizedBox(height: 10),
        _buildTextField(
          label: 'Apellido',
          icon: Icons.person_outline,
          controller: control.apellidoController,
          value: control.apellido,
        ),
        SizedBox(height: 10),
        _buildTextField(
          label: 'DNI',
          icon: Icons.badge,
          controller: control.dniController,
          value: control.dni,
        ),
        SizedBox(height: 10),
        _buildTextField(
          label: 'Correo',
          icon: Icons.email,
          controller: control.correoController,
          value: control.correo,
        ),
        SizedBox(height: 10),
        _buildTextField(
          label: 'Contraseña',
          icon: Icons.lock,
          controller: control.passwordController,
          value: control.password,
          obscureText: true,
        ),
        SizedBox(height: 10),
        _buildTextField(
          label: 'Confirmar Contraseña',
          icon: Icons.lock,
          controller: control.confirmPasswordController,
          value: control.confirmPassword,
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            control.createAccount();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Color(0XFFF26F29), // Cambio de color de fondo del botón
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            child: Text('REGISTRARSE'), // Texto en mayúsculas
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required RxString value,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      onChanged: (newValue) => value.value = newValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(icon),
        border: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.grey), // Color del borde inferior
        ),
        filled: false, // Sin color de fondo
      ),
    );
  }
}
