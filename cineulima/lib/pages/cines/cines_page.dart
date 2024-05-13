import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cines_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class CinesPage extends StatelessWidget {
  final CinesController control = Get.put(CinesController());

  CinesPage({super.key});

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar sala por nombre',
              hintStyle: GoogleFonts.itim(fontSize: 18),
            ),
            onChanged: (value) => control.filtrarSala(value),
          ),
        ),
        Expanded(
          child: Obx(() => ListView.builder(
                itemCount: control.filteredSalas.length,
                itemBuilder: (context, index) {
                  final sala = control.filteredSalas[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.network(sala.imagenUrl,
                          width: 100, height: 100, fit: BoxFit.cover),
                      title: Text(sala.nombre),
                      subtitle: Text(sala.direccion),
                    ),
                  );
                },
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    ));
  }
}
