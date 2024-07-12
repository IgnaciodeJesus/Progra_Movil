import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cines_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../configs/constants.dart';
import '../cineinfo/cineinfo_page.dart';
import '../../models/entities/Sala.dart';

class CinesPage extends StatelessWidget {
  final CinesController control = Get.put(CinesController());

  CinesPage({super.key});

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0XFFD9D9D9)),
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
              child: FutureBuilder<List<Sala>>(
                future: control.fetchSalas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error al cargar las salas'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay salas disponibles'));
                  } else {
                    final salas = snapshot.data!;
                    control.setSalas(salas); // Set the salas to the controller
                    return Obx(() => ListView.builder(
                          itemCount: control.filteredSalas.length,
                          itemBuilder: (context, index) {
                            final sala = control.filteredSalas[index];
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CineInfoPage(sala: sala),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: ListTile(
                                    leading: Image.network(
                                        "${BASE_URL}cinemas/${sala.imagenUrl}",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill),
                                    title: Text(sala.nombre,
                                        style: GoogleFonts.openSans(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w900))),
                                    subtitle: Text(sala.direccion,
                                        style: GoogleFonts.openSans()),
                                  ),
                                ));
                          },
                        ));
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}
