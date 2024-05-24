import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../configs/constants.dart';
import '../../models/entities/Funcion.dart';
import '../../models/entities/Pelicula.dart';
import '../../models/entities/Sala.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MovinfoController extends GetxController {
  late YoutubePlayerController _controller;

  void init(String trailerUrl) async {
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

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  YoutubePlayerController get controller => _controller;

  List<Map<String, dynamic>> getFechasFiltradas(Pelicula pelicula) {
    List<Funcion> funcionesFiltradas = FUNCIONES
        .where((funcion) => funcion.peliculaId == pelicula.id)
        .toList();

    // Agrupar las funciones por fecha (día)
    Map<DateTime, List<Funcion>> funcionesPorFecha = {};
    funcionesFiltradas.forEach((funcion) {
      DateTime fecha = DateTime(funcion.fechahora.year, funcion.fechahora.month,
          funcion.fechahora.day);
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

  List<Map<String, dynamic>> getFuncionesPorFecha(
      Pelicula pelicula, DateTime fecha) {
    List<Funcion> funcionesFiltradas = FUNCIONES
        .where((funcion) =>
            funcion.peliculaId == pelicula.id &&
            DateTime(funcion.fechahora.year, funcion.fechahora.month,
                    funcion.fechahora.day) ==
                fecha)
        .toList();

    funcionesFiltradas.sort((a, b) => a.fechahora.compareTo(b.fechahora));

    Map<int, List<Funcion>> funcionesPorSala = {};
    funcionesFiltradas.forEach((funcion) {
      if (!funcionesPorSala.containsKey(funcion.salaId)) {
        funcionesPorSala[funcion.salaId] = [];
      }
      funcionesPorSala[funcion.salaId]!.add(funcion);
    });

    List<Map<String, dynamic>> funcionesFormateadas = [];
    funcionesPorSala.forEach((salaId, funcionesSala) {
      Sala sala = SALAS.firstWhere((sala) => sala.id == salaId);
      funcionesFormateadas.add({
        'sala': sala.nombre,
        'funciones': funcionesSala
            .map((funcion) => {
                  'funcion': funcion,
                  'horario': DateFormat('HH:mm').format(funcion.fechahora),
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
