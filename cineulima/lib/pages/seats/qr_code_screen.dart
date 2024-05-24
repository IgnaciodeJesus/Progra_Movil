import 'package:cineulima/Widgets/AppBar.dart';
import 'package:cineulima/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart'; // Correct import
import 'package:path/path.dart' as path;

import '../../configs/constants.dart';
import '../../models/entities/Entrada.dart';
import '../../models/entities/Funcion.dart';
import '../../models/entities/Pelicula.dart';
import '../../models/entities/Sala.dart'; // For file path handling

class QRCodeScreen extends StatefulWidget {
  final Entrada entrada;
  final bool fromProfilePage;

  QRCodeScreen({required this.entrada, required this.fromProfilePage});

  @override
  _QRCodeScreenState createState() =>
      _QRCodeScreenState(entrada, fromProfilePage);
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey _globalKey = GlobalKey();
  late Entrada entrada;
  late Funcion funcion;
  late Pelicula pelicula;
  late Sala sala;
  late bool fromProfilePage;

  @override
  void initState() {
    super.initState();
    entrada = widget.entrada;
    funcion = FUNCIONES.firstWhere((f) => f.id == entrada.funcionId);
    pelicula = PELICULAS.firstWhere((p) => p.id == funcion.peliculaId);
    sala = SALAS.firstWhere((s) => s.id == funcion.salaId);
  }

  _QRCodeScreenState(this.entrada, this.fromProfilePage);

  Future<void> _shareQr() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      String imagePath = '${directory.path}/qr_code.png';
      File imageFile = File(imagePath);
      await imageFile.writeAsBytes(pngBytes);

      await Share.shareFiles([imageFile.path],
          text: 'Here is your purchase QR Code');
    } catch (e) {
      print('Error sharing QR code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: fromProfilePage
            ? buildAppBar('Entrada', context, false, true)
            : buildAppBar('Confirmación de compra', context, false, false),
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Text(pelicula.titulo,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontSize: 28.0,
                                color: Color(0xFF000C78),
                                fontWeight: FontWeight.w900,
                              ))),
                          Text(
                              "${sala.nombre} | ${funcion.fechahora.toString().substring(0, 16)}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.itim(
                                  textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ))),
                          SizedBox(height: 20),
                          Text("Muestra este código QR para acceder a la sala",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.itim(
                                  textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ))),
                          SizedBox(height: 10),
                          RepaintBoundary(
                            key: _globalKey,
                            child: QrImageView(
                              data: widget.entrada.id,
                              version: QrVersions.auto,
                              size: 200.0,
                              gapless: false,
                              embeddedImage: AssetImage(
                                  'assets/images/logo.png'), // Optional: embed a logo within the QR code
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Text('Esta entrada no admite cambio de función.',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.itim(
                            textStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ))),
                    SizedBox(height: 10),
                    Text(
                        'Puedes traer tu propia comida, siempre y cuando no molestes a los demás espectadores.',
                        style: GoogleFonts.itim(
                            textStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ))),
                    SizedBox(height: 40),
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 90,
                      ),
                    )
                  ],
                )),
            if (!fromProfilePage)
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                      child: BottomAppBar(
                        height: 50,
                        color: Color(0xFF000C78),
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          padding: EdgeInsets.zero,
                          child: Text('Regresar al inicio',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      height: 1,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w800))),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => HomePage()),
                            (route) => false);
                      })),
          ],
        ));
  }
}
