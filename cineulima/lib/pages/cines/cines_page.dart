import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cines_controller.dart';

class CinesPage extends StatelessWidget {
  CinesController control = Get.put(CinesController());

  CinesPage({super.key});

  Widget _buildBody(BuildContext context) {
    return const SafeArea(
      child: Text('Profile Page'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    ));
  }
}
