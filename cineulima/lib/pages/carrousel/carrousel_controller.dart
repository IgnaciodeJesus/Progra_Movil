import 'package:cineulima/models/responses/home_page_response.dart';
import 'package:cineulima/services/home_page_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CarrouselPageController extends GetxController {
  HomePageService homePageService = HomePageService();
  RxList<HomePageResponse> peliculas = <HomePageResponse>[].obs;

  void fetchData() async {
    List<HomePageResponse>? peliResponse =
        await homePageService.fetchHomePage();
    if (peliResponse.isNotEmpty) {
      peliculas.value = peliResponse;
      print(peliculas.value);
    } else {
      Fluttertoast.showToast(
          msg: "No se encontraron resultados",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
