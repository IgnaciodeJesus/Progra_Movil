import 'dart:convert';
import 'package:cineulima/Widgets/AppBar.dart';
import 'package:cineulima/pages/seats/candy_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/constants.dart';
import '../../models/entities/Entrada.dart';
import '../../models/entities/Usuario.dart';
import '../../models/responses/funciones_response.dart';
import '../../services/reservation_service.dart';
import '../home/home_page.dart';
import '../seats/seat_selection_controller.dart';
import 'package:u_credit_card/u_credit_card.dart';

class PaymentScreen extends StatefulWidget {
  final FuncionesResponse funcion;

  PaymentScreen({required this.funcion});
  @override
  _PaymentScreenState createState() => _PaymentScreenState(funcion);
}

class _PaymentScreenState extends State<PaymentScreen> {
  late FuncionesResponse funcion;
  late Usuario usuario;
  final _formKey = GlobalKey<FormState>();
  final ReservaService reservaService = ReservaService();

  _PaymentScreenState(this.funcion);

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedUser = prefs.getString('logged_user');
    print(loggedUser ?? 'No hay usuario logueado');
    if (loggedUser != null) {
      usuario = Usuario.fromJson(jsonDecode(loggedUser));
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      List<int> selectedSeatIds = Get.find<SeatSelectionController>()
          .selectedSeats
          .map((seat) => seat.id)
          .toList();
      List<Map<String, dynamic>> selectedProducts =
          Get.find<CandySelectionController>()
              .selectedProducts
              .entries
              .map((entry) => {
                    'id': entry.key.id,
                    'cantidad': entry.value,
                  })
              .toList();

      print({
        'user_id': usuario.id,
        'funcion_id': funcion.funcionId,
        'asientos': selectedSeatIds,
        'productos': selectedProducts,
      });

      bool success = await reservaService.createReserva(
        usuario.id,
        funcion.funcionId,
        selectedSeatIds,
        selectedProducts,
      );

      if (success) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();

    _cardNumberController.addListener(() {
      setState(() {});
    });
    _expiryDateController.addListener(() {
      setState(() {});
    });
    _cvvController.addListener(() {
      setState(() {});
    });
    _cardHolderNameController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Pago', context, false, true),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CreditCardUi(
                      cardHolderFullName: _cardHolderNameController.text.isEmpty
                          ? ''
                          : _cardHolderNameController.text,
                      cardNumber: _cardNumberController.text.isEmpty
                          ? ''
                          : _cardNumberController.text,
                      validThru: _expiryDateController.text.isEmpty
                          ? ''
                          : _expiryDateController.text,
                      cvvNumber: _cvvController.text.isEmpty
                          ? ''
                          : _cvvController.text,
                      topLeftColor: Colors.red,
                      doesSupportNfc: true,
                      placeNfcIconAtTheEnd: true,
                      cardType: CardType.debit,
                      cardProviderLogo:
                          Image.asset('assets/images/visa.png', width: 50),
                      cardProviderLogoPosition: CardProviderLogoPosition.right,
                      showBalance: false,
                      enableFlipping: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      labelText: 'Número de tarjeta',
                      hintText: '1234 5678 9012 3456',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 16) {
                        return 'Please enter a valid card number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _expiryDateController,
                    decoration: InputDecoration(
                      labelText: 'Fecha de expiración',
                      hintText: 'MM/YY',
                    ),
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5),
                      _CardExpiryInputFormatter(),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 5) {
                        return 'Please enter a valid expiry date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cvvController,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      hintText: '123',
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 3) {
                        return 'Please enter a valid CVV';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cardHolderNameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre en tarjeta',
                      hintText: 'John Doe',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the cardholder name';
                      }
                      return null;
                    },
                  ),
                ],
              ),
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
                  child: Text('Finalizar compra',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              height: 1,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800))),
                ),
              ),
              onTap: () {
                _submitForm();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }
}

class _CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length < 5) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
