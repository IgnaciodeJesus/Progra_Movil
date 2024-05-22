import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './loginController.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginController control = Get.put(LoginController());

  Widget _form(BuildContext context, bool isKeyBoardOpen) {
    return Container(
      height: 290,
      decoration: BoxDecoration(
          color: Color(0xFFFDE0B4),
          borderRadius: BorderRadius.circular(20),
          ),
      margin: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.1, // Margen izquierdo
        MediaQuery.of(context).size.width * (isKeyBoardOpen ? 0.3 : 0.65), //  Margen superior
        MediaQuery.of(context).size.width * 0.1, // Margen derecho
        MediaQuery.of(context).size.width * 0.1, // Margen inferior
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                labelText: 'DNI', // Etiqueta del campo de texto
                labelStyle: TextStyle(color: Colors.black),
                border: UnderlineInputBorder(
                    borderRadius:
                        BorderRadius.zero), // Borde del campo de texto
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black),
                       // Color del borde al enfocar
                ),
                prefixIcon: Icon(
                Icons.person, // Aquí puedes poner el ícono que desees
                color: Colors.black, // Ajusta el color del ícono si es necesario
                ),
              ),
              controller: control.userController,
            ),
            SizedBox(
              height: 6,
            ),
            TextField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Contraseña', // Etiqueta del campo de texto
                labelStyle: TextStyle(color: Colors.black),
                border: UnderlineInputBorder(
                    borderRadius:
                        BorderRadius.zero), // Borde del campo de texto
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // Colr del borde al enfocaro
                ),
                prefixIcon: Icon(
                Icons.lock, // Ícono de candado
                color: Colors.black, // Ajusta el color del ícono si es necesario
                ),
              ),
              controller: control.passController,
              obscureText: true,
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity, // Ocupar todo el ancho disponible
              child: TextButton(
                onPressed: () {
                  // Función que se ejecuta cuando se presiona el botón
                  control.login(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      Color(0XFFF26F29), // Color de fondo del botón
                  padding: EdgeInsets
                      .zero, // Padding cero para eliminar el espacio interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Bordes cero para eliminar los bordes
                  ),
                ),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.black, // Color del texto
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Obx(() => Text(
                  control.message.value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: control.messageColor.value,
                  ),
                ),
              ),
            _links(context)
          ])
        ],
      ),
    );
  }

  Widget _links(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/recover');
                },
                child: Text(
                  'Olvidé mi contraseña',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0000FF),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }

  Widget _background(BuildContext context) {
    return Container(color: Color(0XFFFFFFFF));
  }

  Widget _imageBackground(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8, // 80% del ancho de la pantalla
                    height: MediaQuery.of(context).size.height * 0.25, // 40% de la altura de la pantalla
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/login.png'),
                            fit: BoxFit.contain)),
                )
            ),
        Expanded(child: Text(''), flex: 1),
      ],
    );
  }

  Widget _titlePage(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.28, // Margen izquierdo
        MediaQuery.of(context).size.width * 0.5,
        MediaQuery.of(context).size.width * 0.28,
        MediaQuery.of(context).size.width * 0.1,
        ),
          child: Text(
            'Inicio de sesión',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
         );
  }  

  Widget _signuPPage(BuildContext context) {
    return Container(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, 
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '¿No tienes una cuenta? ',
                                style: TextStyle(fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/signup');
                                },
                                child: Text(
                                  'Regístrate',
                                  style: TextStyle(
                                    color: Color(0xFF0000FF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                    ),
                SizedBox(height: 150),
            ]
    ),
    );
  } 

  Widget _buildBody(BuildContext context) {
    final bool isKeyBoardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    print('1 +++++++++++++++++++++++++');
    print(isKeyBoardOpen);
    print('2 +++++++++++++++++++++++++');
    return Stack(children: [
      _background(context),
      _imageBackground(context),
      _titlePage(context),
      _form(context, isKeyBoardOpen),
      _signuPPage(context),
    ]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFF26F29),
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(context),
    );
  }
}