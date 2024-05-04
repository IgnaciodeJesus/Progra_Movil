import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'movies_controller.dart';

class MoviesPage extends StatelessWidget {
  MoviesController control = Get.put(MoviesController());


  Widget _buildBody(BuildContext context) {
    final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight - 124) / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: (itemWidth / itemHeight),
        children: control.peliculas.map((p) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Image.network(
              p.imagenUrl,
              fit: BoxFit.fill,
            ),
          );
        }).toList(),
      ),
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
