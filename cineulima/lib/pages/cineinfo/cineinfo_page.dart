import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cineinfo_controller.dart'; // Asegúrate de que este importe esté correcto
import 'package:google_fonts/google_fonts.dart';

class CineInfoPage extends StatelessWidget {
  final CineInfoController control = Get.put(CineInfoController());

  CineInfoPage({Key? key}) : super(key: key);

  Widget _buildBody(BuildContext context) {
    return const SafeArea(
      child: Text('Información del Cine'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 5,
        title: Text(
          'Cines',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: const Color(0XFFF26F29),
      ),
      body: _buildBody(context),
    );
  }
}
