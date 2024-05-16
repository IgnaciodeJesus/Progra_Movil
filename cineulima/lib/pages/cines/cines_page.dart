import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cines_controller.dart';
import '../cineinfo/cineinfo_page.dart'; // Asegúrate de que este importe esté correcto
import 'package:google_fonts/google_fonts.dart';

class CinesPage extends StatelessWidget {
  final CinesController control = Get.put(CinesController());

  CinesPage({super.key});

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(color: Color(0XFFD9D9D9)),
        Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Buscar sala por nombre',
                    hintStyle: GoogleFonts.itim(fontSize: 18),
                    border: InputBorder.none),
                onChanged: (value) => control.filtrarSala(value),
              ),
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: control.filteredSalas.length,
                    itemBuilder: (context, index) {
                      final sala = control.filteredSalas[index];
                      return Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: Image.network(sala.imagenUrl,
                              width: 100, height: 100, fit: BoxFit.fill),
                          title: Text(sala.nombre,
                              style: GoogleFonts.openSans(
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.w900))),
                          subtitle: Text(sala.direccion,
                              style: GoogleFonts.openSans()),
                          onTap: () {
                            if (Get.context != null) {
                              Get.to(() => CineInfoPage());
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CineInfoPage()));
                            }
                          },
                        ),
                      );
                    },
                  )),
            ),
          ],
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
      ),
    );
  }
}
