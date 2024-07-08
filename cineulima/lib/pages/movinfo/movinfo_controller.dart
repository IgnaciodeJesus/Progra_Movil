import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../services/peliculas_service.dart';
import '../../services/function_service.dart';
import '../../models/responses/peliculas_home_response.dart';
import '../../models/responses/funciones_response.dart';

class MovinfoController extends GetxController {
  PeliculasService peliculasService = PeliculasService();
  FunctionService functionService = FunctionService();
  Rx<PeliculasInfoResponse> pelicula =
      Rx<PeliculasInfoResponse>(PeliculasInfoResponse.empty());
  RxList<FuncionesResponse> funciones = <FuncionesResponse>[].obs;
  late YoutubePlayerController _controller;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('es'); // Inicializa la localización para español
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  YoutubePlayerController get controller => _controller;

  Future<void> fetchPeliculasInfo(int id) async {
    PeliculasInfoResponse? peliResponse =
        await peliculasService.fetchPeliculasPage(id);
    if (peliResponse.peliculadata.id != 0) {
      pelicula.value = peliResponse;
      init(peliResponse.peliculadata
          .trailerUrl); // Initialize YouTube player with trailer URL
      await fetchFunciones(id); // Fetch functions for the movie
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

  Future<void> fetchFunciones(int movieId) async {
    funciones.value = await functionService.fetchFunctionsByMovieId(movieId);
  }

  void init(String trailerUrl) {
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
    List<FuncionesResponse> funcionesFiltradas = funciones;
    Map<DateTime, List<FuncionesResponse>> funcionesPorFecha = {};
    funcionesFiltradas.forEach((funcion) {
      DateTime fecha = DateTime(funcion.fechaHora.year, funcion.fechaHora.month,
          funcion.fechaHora.day);
      if (!funcionesPorFecha.containsKey(fecha)) {
        funcionesPorFecha[fecha] = [];
      }
      funcionesPorFecha[fecha]!.add(funcion);
    });

    List<Map<String, dynamic>> fechasFormateadas = [];
    funcionesPorFecha.forEach((fecha, funcionesFecha) {
      String diaSemana = DateFormat('EEEE', 'es').format(fecha);
      diaSemana = diaSemana[0].toUpperCase() + diaSemana.substring(1);
      String mesString = DateFormat('MMMM', 'es').format(fecha);
      mesString = mesString[0].toUpperCase() + mesString.substring(1);
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
    List<FuncionesResponse> funcionesFiltradas = funciones
        .where((funcion) =>
            DateTime(funcion.fechaHora.year, funcion.fechaHora.month,
                funcion.fechaHora.day) ==
            fecha)
        .toList();
    funcionesFiltradas.sort((a, b) => a.fechaHora.compareTo(b.fechaHora));

    Map<String, List<FuncionesResponse>> funcionesPorSala = {};
    funcionesFiltradas.forEach((funcion) {
      if (!funcionesPorSala.containsKey(funcion.salaNombre)) {
        funcionesPorSala[funcion.salaNombre] = [];
      }
      funcionesPorSala[funcion.salaNombre]!.add(funcion);
    });

    List<Map<String, dynamic>> funcionesFormateadas = [];
    funcionesPorSala.forEach((nombreSala, funcionesSala) {
      funcionesFormateadas.add({
        'sala': nombreSala,
        'funciones': funcionesSala
            .map((funcion) => {
                  'funcion': funcion,
                  'horario': DateFormat('HH:mm').format(funcion.fechaHora),
                })
            .toList(),
      });
    });

    return funcionesFormateadas;
  }

  Rx<DateTime> selectedDate = DateTime(2024, 4, 23, 15, 30, 0).obs;
  RxList<Map<String, dynamic>> funcionesFiltradas =
      <Map<String, dynamic>>[].obs;
}
