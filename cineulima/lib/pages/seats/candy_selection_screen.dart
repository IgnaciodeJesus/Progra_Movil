import 'package:flutter/material.dart';
import 'seat_selection_screen.dart'; // Import the SeatSelectionScreen widget
import 'payment_confirmation_screen.dart'; // Make sure to create and import this widget
import 'package:cineulima/models/entities/candy.dart';
import 'package:cineulima/models/entities/seat.dart';

class CandySalesScreen extends StatefulWidget {
  final double seatTotal; // This is the total from the seat selection screen

  CandySalesScreen({required this.seatTotal});

  @override
  _CandySalesScreenState createState() => _CandySalesScreenState();
}

class _CandySalesScreenState extends State<CandySalesScreen> {
  List<Product> products = [
    Product(name: "Combo 1", price: 10.0, imageUrl: "assets/images/regular_combo.webp"),
    Product(name: "Candy Bar", price: 5.0, imageUrl: "assets/images/candy_bar.webp"),
    // Add more products here
  ];

  Map<Product, int> selectedProducts = {};
  double candyTotal = 0.0;

  void addToTotal(Product product) {
    setState(() {
      if (selectedProducts.containsKey(product)) {
        selectedProducts[product] = selectedProducts[product]! + 1;
      } else {
        selectedProducts[product] = 1;
      }
      candyTotal += product.price;
    });
  }

  void removeFromTotal(Product product) {
    if (selectedProducts.containsKey(product) && selectedProducts[product]! > 0) {
      setState(() {
        selectedProducts[product] = selectedProducts[product]! - 1;
        candyTotal -= product.price;
      });
    }
  }

  double get grandTotal => widget.seatTotal + candyTotal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Candy Sales")),
      body: SingleChildScrollView( // Adds scrolling capability to the layout
        child: Column(
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true, // Ensures the GridView takes up only as much space as it needs
              physics: NeverScrollableScrollPhysics(), // Disables scrolling within the GridView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(product.imageUrl, fit: BoxFit.cover, height: 80),
                      Text(product.name),
                      Text("\$${product.price}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => removeFromTotal(product),
                          ),
                          Text(selectedProducts[product]?.toString() ?? '0'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => addToTotal(product),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Candy Total: \$${candyTotal.toStringAsFixed(2)}", style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Seat Total: \$${widget.seatTotal.toStringAsFixed(2)}", style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Grand Total: \$${grandTotal.toStringAsFixed(2)}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()), // Assuming PaymentScreen is your payment form screen
                );
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
