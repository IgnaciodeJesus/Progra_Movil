import 'package:cineulima/pages/Perfil/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilPage extends StatelessWidget {
  PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Crea una instancia del controlador
    final PerfilController controller =
        Get.put(PerfilController(), permanent: true);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(controller),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
          SizedBox(height: 50),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(controller.usuario.fotoPerfil),
          ),
          SizedBox(height: 20),
          Text(
            "${controller.usuario.nombre} ${controller.usuario.apellido}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            "DNI: ${controller.usuario.dni}",
            style: TextStyle(fontSize: 20),
          ),
          Divider(height: 40, thickness: 2),
          Text(
            "Mis Entradas",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.funciones.length,
                itemBuilder: (context, index) {
                  final funcion = controller.funciones[index];
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
                          fit: BoxFit.cover),
                      title: Text(
                        "${controller.getPeliculaNombre(funcion.peliculaId)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${funcion.fechahora.toIso8601String().substring(0, 10)} | ${funcion.fechahora.toIso8601String().substring(11, 16)}",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Sala: ${controller.getSalaNombre(funcion.salaId)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
