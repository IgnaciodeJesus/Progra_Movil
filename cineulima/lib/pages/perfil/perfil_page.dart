import 'package:cineulima/pages/Perfil/perfil_controller.dart';
import 'package:cineulima/pages/seats/qr_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io'; // Para usar FileImage
import '../../configs/constants.dart';
import 'package:cineulima/pages/login/LoginPage.dart';

class PerfilPage extends StatelessWidget {
  PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Crea una instancia del controlador
    final PerfilController controller =
        Get.put(PerfilController(), permanent: true);
    controller.onInit();
    return Scaffold(
      appBar: _buildAppBar(context, controller),
      body: _buildBody(controller),
    );
  }

  AppBar _buildAppBar(BuildContext context, PerfilController controller) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 5,
      title: Text(
        'Perfil',
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            controller.logOutUser(context);
          },
          icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 40),
          tooltip: "Ver perfil",
        ),
      ],
      backgroundColor: Color(0XFFF26F29),
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildBody(PerfilController controller) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40),
          Obx(() => GestureDetector(
                onTap: () => controller.actualizarFotoPerfil(),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300], // Fondo gris
                  // Usamos el operador ternario para manejar la imagen de fondo o el ícono
                  backgroundImage:
                      controller.usuario.value.fotoPerfil.isNotEmpty
                          ? FileImage(File(controller.usuario.value.fotoPerfil))
                              as ImageProvider
                          : null,
                  child: controller.usuario.value.fotoPerfil.isEmpty
                      ? Icon(Icons.camera_alt,
                          size: 30, color: Colors.black) // Ícono de cámara
                      : null, // No mostrar ícono si hay imagen
                ),
              )),
          SizedBox(height: 20),
          Obx(() => Text(
              "${controller.usuario.value.nombre} ${controller.usuario.value.apellido}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          Obx(() => Text("DNI: ${controller.usuario.value.dni}",
              style: TextStyle(fontSize: 20))),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              height: 40,
              thickness: 2.0,
              color: Colors.black,
            ),
          ),
          Text("Mis Entradas",
              style: GoogleFonts.openSans(
                textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              )),
          SizedBox(
            height: 5,
          ),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.entradas.value.length,
              itemBuilder: (context, index) {
                final entrada = controller.entradas.value[index];
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.network(
                          controller.getPeliculaImagenUrl(entrada),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter),
                      title: Text("${controller.getPeliculaNombre(entrada)}",
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w900))),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.getFuncion(entrada).fechahora.toIso8601String().substring(0, 10)} | ${controller.getFuncion(entrada).fechahora.toIso8601String().substring(11, 16)}",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                          ),
                          SizedBox(height: 2),
                          Text("Sala: ${controller.getSalaNombre(entrada)}",
                              style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w900))),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRCodeScreen(
                                  entrada: entrada,
                                  fromProfilePage: true,
                                )));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
