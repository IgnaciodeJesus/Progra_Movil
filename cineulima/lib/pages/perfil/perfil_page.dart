import 'package:cineulima/pages/Perfil/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/constants.dart';

class PerfilPage extends StatelessWidget {
  PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Crea una instancia del controlador
    final PerfilController controller =
        Get.put(PerfilController(), permanent: true);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(controller),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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
      backgroundColor: Color(0XFFF26F29),
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildBody(PerfilController controller) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(controller.usuario.fotoPerfil),
          ),
          SizedBox(height: 20),
          Text(
            "${controller.usuario.nombre} ${controller.usuario.apellido}",
            style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),)
          ),
          Text(
            "DNI: ${controller.usuario.dni}",
            style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              height: 40,
              thickness: 2.0,
              color: Colors.black,
            ),
          ),
          Text(
            "Mis Entradas",
            style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),)
          ),
          SizedBox(height: 5,),
          ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: FUNCIONES.length,
                itemBuilder: (context, index) {
                  final funcion = FUNCIONES[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.network(
                          controller.getPeliculaImagenUrl(funcion.peliculaId),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter),
                      title: Text(
                        "${controller.getPeliculaNombre(funcion.peliculaId)}",
                        style: GoogleFonts.openSans(textStyle: const TextStyle(fontWeight: FontWeight.w900))
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${funcion.fechahora.toIso8601String().substring(0, 10)} | ${funcion.fechahora.toIso8601String().substring(11, 16)}",
                            style: GoogleFonts.openSans(textStyle:TextStyle(color: Colors.black.withOpacity(0.8))),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Sala: ${controller.getSalaNombre(funcion.salaId)}",
                            style: GoogleFonts.openSans(textStyle: const TextStyle(fontWeight: FontWeight.w900))
                          ),
                        ],
                      ),
                    ),
                  );
                },
          ),
        ],
      ),
    );
  }
}
