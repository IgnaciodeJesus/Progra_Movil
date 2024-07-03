import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../configs/constants.dart';
import '../../models/entities/Funcion.dart';
import '../../models/entities/Pelicula.dart';
import '../../models/entities/Sala.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../services/peliculas_service.dart';
import 'package:cineulima/models/responses/peliculas_home_response.dart';

class MovinfoController extends GetxController {
  PeliculasService peliculasService = PeliculasService();
  Rx<PeliculasInfoResponse> pelicula = Rx<PeliculasInfoResponse>(PeliculasInfoResponse.empty());
  late YoutubePlayerController _controller;

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  YoutubePlayerController get controller => _controller;

  Future<void> fetchPeliculasInfo(int id) async {
    PeliculasInfoResponse? peliResponse = await peliculasService.fetchPeliculasPage(id);
    if (peliResponse.id != 0) {
      pelicula.value = peliResponse;
      print("se encontro gaaaa");
      init(peliResponse.trailerUrl); // Initialize YouTube player with trailer URL
    } else {
      Fluttertoast.showToast(
          msg: "No se encontraron resultados",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print("No se encontro");
    }
    print(peliResponse.sinopsis);
    print("ya fue ya xd");
    print(pelicula.value.toJson());
  }

  void init(String trailerUrl) {
    initializeDateFormatting('es');
    String videoId = YoutubePlayer.convertUrlToId(trailerUrl) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
  }

  List<Map<String, dynamic>> getFechasFiltradas() {
    List<FuncionesInfoResponse> funcionesFiltradas = pelicula.value.funciones;
    // Agrupar las funciones por fecha (día)
    Map<DateTime, List<FuncionesInfoResponse>> funcionesPorFecha = {};
    funcionesFiltradas.forEach((funcion) {
      DateTime fecha = DateTime(funcion.fecha.year, funcion.fecha.month,
          funcion.fecha.day);
      if (!funcionesPorFecha.containsKey(fecha)) {
        funcionesPorFecha[fecha] = [];
      }
      funcionesPorFecha[fecha]!.add(funcion);
    });

    // Formatear las funciones agrupadas por fecha
    List<Map<String, dynamic>> fechasFormateadas = [];
    funcionesPorFecha.forEach((fecha, funcionesFecha) {
      String diaSemana = DateFormat('EEEE', 'es').format(fecha);
      diaSemana = diaSemana[0].toUpperCase() + diaSemana.substring(1);
      String mesString = DateFormat('MMMM', 'es').format(fecha);
      mesString = mesString[0].toUpperCase() + diaSemana.substring(1);
      fechasFormateadas.add({
        'diaSemana': diaSemana,
        'diaMes': DateFormat('dd', 'es').format(fecha),
        'mes': mesString,
        'value': fecha,
      });
    });

    return fechasFormateadas;
  }

  List<Map<String, dynamic>> getFuncionesPorFecha(DateTime fecha) {
    List<FuncionesInfoResponse> funcionesFiltradas = pelicula.value.funciones
        .where((funcion) =>
    DateTime(funcion.fecha.year, funcion.fecha.month,
        funcion.fecha.day) ==
        fecha)
        .toList();
    funcionesFiltradas.sort((a, b) => a.fecha.compareTo(b.fecha));

    Map<String, List<FuncionesInfoResponse>> funcionesPorSala = {};
    funcionesFiltradas.forEach((funcion) {
      if (!funcionesPorSala.containsKey(funcion.nombre_sala)) {
        funcionesPorSala[funcion.nombre_sala] = [];
      }
      funcionesPorSala[funcion.nombre_sala]!.add(funcion);
    });

    List<Map<String, dynamic>> funcionesFormateadas = [];
    funcionesPorSala.forEach((nombreSala, funcionesSala) {
      funcionesFormateadas.add({
        'sala': nombreSala,
        'funciones': funcionesSala
            .map((funcion) => {
          'funcion': funcion,
          'horario': DateFormat('HH:mm').format(funcion.fecha),
        })
            .toList(),
      });
    });

    return funcionesFormateadas;
  }

  Rx<DateTime> selectedDate = DateTime(2024, 4, 23, 15, 30, 0).obs;
  RxList<Map<String, dynamic>> funcionesFiltradas = <Map<String, dynamic>>[].obs;
}
