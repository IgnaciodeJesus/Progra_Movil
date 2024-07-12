import 'package:cineulima/models/entities/Historial.dart';
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
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;
import '../../configs/constants.dart';

class QRCodeScreen extends StatefulWidget {
  final Historial historial;
  final bool fromProfilePage;

  QRCodeScreen({required this.historial, required this.fromProfilePage});

  @override
  _QRCodeScreenState createState() =>
      _QRCodeScreenState(historial, fromProfilePage);
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey _globalKey = GlobalKey();
  late Historial historial;
  late bool fromProfilePage;

  _QRCodeScreenState(this.historial, this.fromProfilePage);

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

  String construirUrlImagen(String imagen) {
    return '${BASE_URL}movies/$imagen';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fromProfilePage
          ? buildAppBar('Entrada', context, false, true)
          : buildAppBar('Confirmación de compra', context, false, false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                child: Column(
                  children: <Widget>[
                    Text(historial.pelicula.titulo,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontSize: 28.0,
                          color: Color(0xFF000C78),
                          fontWeight: FontWeight.w900,
                        ))),
                    Text(
                        "${historial.sala.nombre} | ${historial.fechaFuncion.toString().substring(0, 16)}",
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
                        data: historial.reservaId.toString(),
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
              ),
              SizedBox(height: 20),
              Text("Detalles de la Reserva",
                  style: GoogleFonts.openSans(
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  )),
              SizedBox(height: 10),
              Text(
                  "Asientos: ${historial.asientos.map((asiento) => '${asiento.fila}${asiento.columna}').join(', ')}",
                  style: GoogleFonts.openSans(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )),
              SizedBox(height: 10),
              Text("Productos:",
                  style: GoogleFonts.openSans(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )),
              Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0XFFF26F29),
                    ),
                    children: [
                      TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Nombre',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                      TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Cant.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                      TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Precio',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                      TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Total',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                    ],
                  ),
                  ...historial.productos.map((producto) => TableRow(
                        decoration: BoxDecoration(
                          color: const Color(0XFFD9D9D9),
                        ),
                        children: [
                          TableCell(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(producto.nombre,
                                      style: GoogleFonts.itim()))),
                          TableCell(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(producto.cantidad.toString(),
                                      style: GoogleFonts.itim()))),
                          TableCell(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(producto.precio.toString(),
                                      style: GoogleFonts.itim()))),
                          TableCell(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(producto.total.toString(),
                                      style: GoogleFonts.itim()))),
                        ],
                      )),
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xFF000C78),
                    ),
                    children: [
                      TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Total',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                      TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                      TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                      TableCell(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(historial.gastoTotal.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: !fromProfilePage
          ? GestureDetector(
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
              })
          : null,
    );
  }
}
