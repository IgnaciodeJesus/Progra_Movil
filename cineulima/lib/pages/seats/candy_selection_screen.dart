// import 'package:cineulima/Widgets/AppBar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../models/entities/Funcion.dart';
// import 'seat_selection_screen.dart'; // Import the SeatSelectionScreen widget
// import 'payment_confirmation_screen.dart'; // Make sure to create and import this widget
// import 'package:cineulima/models/entities/candy.dart';
// import 'package:cineulima/models/entities/seat.dart';

// class CandySalesScreen extends StatefulWidget {
//   final double seatTotal;
//   final Funcion funcion;

//   CandySalesScreen({required this.seatTotal, required this.funcion});

//   @override
//   _CandySalesScreenState createState() => _CandySalesScreenState(funcion);
// }

// class _CandySalesScreenState extends State<CandySalesScreen> {
//   late Funcion funcion;

//   _CandySalesScreenState(this.funcion);

//   List<Product> products = [
//     Product(
//         name: "Combo 1",
//         price: 10.0,
//         imageUrl: "assets/images/regular_combo.webp"),
//     Product(
//         name: "Candy Bar",
//         price: 5.0,
//         imageUrl: "assets/images/candy_bar.webp"),
//     // Add more products here
//   ];

//   Map<Product, int> selectedProducts = {};
//   double candyTotal = 0.0;

//   void addToTotal(Product product) {
//     setState(() {
//       if (selectedProducts.containsKey(product)) {
//         selectedProducts[product] = selectedProducts[product]! + 1;
//       } else {
//         selectedProducts[product] = 1;
//       }
//       candyTotal += product.price;
//     });
//   }

//   void removeFromTotal(Product product) {
//     if (selectedProducts.containsKey(product) &&
//         selectedProducts[product]! > 0) {
//       setState(() {
//         selectedProducts[product] = selectedProducts[product]! - 1;
//         candyTotal -= product.price;
//       });
//     }
//   }

//   double get grandTotal => widget.seatTotal + candyTotal;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: buildAppBar('Confitería', context, false, true),
//         body: Stack(
//           children: [
//             Container(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: <Widget>[
//                   GridView.builder(
//                     shrinkWrap:
//                         true, // Ensures the GridView takes up only as much space as it needs
//                     physics:
//                         NeverScrollableScrollPhysics(), // Disables scrolling within the GridView
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.8,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       var product = products[index];
//                       return Card(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: <Widget>[
//                             Image.asset(product.imageUrl,
//                                 fit: BoxFit.cover, height: 80),
//                             Text(product.name,
//                                 style: GoogleFonts.inter(
//                                     textStyle: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w700,
//                                 ))),
//                             Text("S/.${product.price}",
//                                 style: GoogleFonts.itim(
//                                     textStyle: const TextStyle(
//                                   color: Colors.black87,
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w500,
//                                 ))),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: <Widget>[
//                                 IconButton(
//                                   icon: Icon(Icons.remove),
//                                   onPressed: () => removeFromTotal(product),
//                                 ),
//                                 Text(
//                                     selectedProducts[product]?.toString() ??
//                                         '0',
//                                     style: GoogleFonts.inter(
//                                         textStyle: const TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 15.0,
//                                       fontWeight: FontWeight.w700,
//                                     ))),
//                                 IconButton(
//                                   icon: Icon(Icons.add),
//                                   onPressed: () => addToTotal(product),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: Text(
//                         "Total Confiteria: \$${candyTotal.toStringAsFixed(2)}",
//                         style: GoogleFonts.inter(
//                             textStyle: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w500,
//                         ))),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: Text(
//                         "Total Asientos: \$${widget.seatTotal.toStringAsFixed(2)}",
//                         style: GoogleFonts.inter(
//                             textStyle: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w500,
//                         ))),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: Text("Total: \$${grandTotal.toStringAsFixed(2)}",
//                         style: GoogleFonts.inter(
//                             textStyle: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.w900,
//                         ))),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: GestureDetector(
//                     child: BottomAppBar(
//                       height: 50,
//                       color: Color(0xFF000C78),
//                       child: Container(
//                         color: Colors.transparent,
//                         alignment: Alignment.center,
//                         padding: EdgeInsets.zero,
//                         child: Text('Proceder a pago',
//                             style: GoogleFonts.inter(
//                                 textStyle: const TextStyle(
//                                     color: Colors.white,
//                                     height: 1,
//                                     fontSize: 22.0,
//                                     fontWeight: FontWeight.w800))),
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 PaymentScreen(funcion: funcion)),
//                       );
//                     }))
//           ],
//         ));
//   }
// }
