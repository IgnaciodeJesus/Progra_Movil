import 'package:cineulima/Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';  // Correct import
import 'package:path/path.dart' as path;  // For file path handling

class QRCodeScreen extends StatefulWidget {
  final String purchaseDetails;

  QRCodeScreen({required this.purchaseDetails});

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> _shareQr() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      String imagePath = '${directory.path}/qr_code.png';
      File imageFile = File(imagePath);
      await imageFile.writeAsBytes(pngBytes);

      await Share.shareFiles([imageFile.path], text: 'Here is your purchase QR Code');
    } catch (e) {
      print('Error sharing QR code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Confirmación de compra', context, false, false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Este es el código QR de tu compra", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            RepaintBoundary(
              key: _globalKey,
              child: QrImageView(
                data: widget.purchaseDetails,
                version: QrVersions.auto,
                size: 200.0,
                gapless: false,
                embeddedImage: AssetImage('assets/logo.png'), // Optional: embed a logo within the QR code
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(60, 60), // Size of the embedded image
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _shareQr,
              child: Text('Share QR Code'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                foregroundColor: Colors.white, // Foreground color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
