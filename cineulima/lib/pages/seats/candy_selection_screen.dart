import 'package:cineulima/Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../models/entities/Producto.dart';
import '../../services/product_service.dart';
import '../../models/responses/funciones_response.dart';
import 'candy_selection_controller.dart';
import '../../configs/constants.dart';
import '../seats/payment_confirmation_screen.dart'; // Importamos la pantalla de pago

class CandySalesScreen extends StatefulWidget {
  final double seatTotal;
  final FuncionesResponse funcion;

  CandySalesScreen({required this.seatTotal, required this.funcion});

  @override
  _CandySalesScreenState createState() => _CandySalesScreenState(funcion);
}

class _CandySalesScreenState extends State<CandySalesScreen> {
  final FuncionesResponse funcion;
  final CandySelectionController controller =
      Get.put(CandySelectionController());

  _CandySalesScreenState(this.funcion);

  @override
  void initState() {
    super.initState();
    controller.fetchProducts();
  }

  void addToTotal(Producto product) {
    controller.addToTotal(product);
  }

  void removeFromTotal(Producto product) {
    controller.removeFromTotal(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Confitería', context, false, true),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Obx(() {
                  return controller.products.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          height: 200, // Ajusta la altura según sea necesario
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.products.length,
                            itemBuilder: (context, index) {
                              var product = controller.products[index];
                              return Container(
                                width:
                                    160, // Ajusta el ancho según sea necesario
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Image.network(
                                        '${BASE_URL}productos/${product.imagen}',
                                        fit: BoxFit.cover,
                                        height: 80,
                                      ),
                                      Text(product.nombre,
                                          style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                          ))),
                                      Text("S/.${product.precio}",
                                          style: GoogleFonts.itim(
                                              textStyle: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () =>
                                                removeFromTotal(product),
                                          ),
                                          Obx(() {
                                            return Text(
                                              controller
                                                      .selectedProducts[product]
                                                      ?.toString() ??
                                                  '0',
                                              style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w700,
                                              )),
                                            );
                                          }),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () =>
                                                addToTotal(product),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                }),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Obx(() {
                    return Text(
                      "Total Confitería: S/.${controller.candyPrice.value.toStringAsFixed(2)}",
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      )),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                      "Total Asientos: S/.${widget.seatTotal.toStringAsFixed(2)}",
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Obx(() {
                    return Text(
                      "Total: S/.${(widget.seatTotal + controller.candyPrice.value).toStringAsFixed(2)}",
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      )),
                    );
                  }),
                ),
              ],
            ),
          ),
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
                  child: Text('Proceder a pago',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              height: 1,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800))),
                ),
              ),
              onTap: () {
                // Navegar a la pantalla de pago
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaymentScreen(funcion: widget.funcion),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
