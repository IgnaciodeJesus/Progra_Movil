import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../models/entities/Funcion.dart';
import '../../models/entities/Pelicula.dart';
import '../../models/entities/Sala.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MovinfoController extends GetxController {
  late YoutubePlayerController _controller;

  List<Sala> salas = [
    Sala(id: 1,
        nombre: "Sala A",
        direccion: "Dirección A",
        imagenUrl: "https://skytower.com.tr/wp-content/uploads/2023/04/IMG-20230417-WA0048.jpg"),
    Sala(id: 2,
        nombre: "Sala B",
        direccion: "Dirección B",
        imagenUrl: "https://images.adsttc.com/media/images/5cb9/fc6c/284d/d198/f600/027f/newsletter/1.jpg?1555692647"),
    Sala(id: 3,
        nombre: "Sala C",
        direccion: "Dirección C",
        imagenUrl: "https://static.dezeen.com/uploads/2013/04/Dezeen_Agora-Garden-by-Vincent-Callebaut-Architectures_ss_2.jpg"),
    Sala(id: 4,
        nombre: "Sala D",
        direccion: "Dirección D",
        imagenUrl: "https://harborviewmadison.com/wp-content/uploads/2023/03/Use-4.jpg"),
    Sala(id: 5,
        nombre: "Sala E",
        direccion: "Dirección E",
        imagenUrl: "https://media.wired.co.uk/photos/619facd0424af1246ccd296a/master/w_1600%2Cc_limit/WW2022-WIRED-26.jpg"),
    Sala(id: 6,
        nombre: "Sala F",
        direccion: "Dirección F",
        imagenUrl: "https://gawcapital.s3.ap-southeast-1.amazonaws.com/media/wp-content/uploads/2021/04/1fd4537eb078b99a2961574a9a1d58dc.jpeg"),
  ];

  List<Funcion> funciones = [
    Funcion(id: 1,
        peliculaId: 1,
        salaId: 1,
        fechahora: DateTime(2024, 4, 23, 15, 30, 0)),
    Funcion(id: 2,
        peliculaId: 1,
        salaId: 2,
        fechahora: DateTime(2024, 4, 23, 19, 30, 0)),
    Funcion(id: 3,
        peliculaId: 1,
        salaId: 3,
        fechahora: DateTime(2024, 4, 23, 16, 0, 0)),
    Funcion(id: 4,
        peliculaId: 1,
        salaId: 4,
        fechahora: DateTime(2024, 4, 23, 17, 30, 0)),
    Funcion(id: 5,
        peliculaId: 1,
        salaId: 5,
        fechahora: DateTime(2024, 4, 23, 18, 20, 0)),
    Funcion(id: 6,
        peliculaId: 1,
        salaId: 6,
        fechahora: DateTime(2024, 4, 23, 20, 30, 0)),
    Funcion(id: 7,
        peliculaId: 1,
        salaId: 1,
        fechahora: DateTime(2024, 4, 23, 21, 30, 0)),
    Funcion(id: 8,
        peliculaId: 1,
        salaId: 2,
        fechahora: DateTime(2024, 4, 23, 22, 30, 0)),
    Funcion(id: 1,
        peliculaId: 1,
        salaId: 1,
        fechahora: DateTime(2024, 4, 24, 15, 30, 0)),
    Funcion(id: 2,
        peliculaId: 1,
        salaId: 2,
        fechahora: DateTime(2024, 4, 24, 19, 30, 0)),
    Funcion(id: 3,
        peliculaId: 1,
        salaId: 3,
        fechahora: DateTime(2024, 4, 24, 16, 0, 0)),
    Funcion(id: 1,
        peliculaId: 1,
        salaId: 1,
        fechahora: DateTime(2024, 4, 25, 14, 30, 0)),
    Funcion(id: 2,
        peliculaId: 1,
        salaId: 2,
        fechahora: DateTime(2024, 4, 25, 16, 45, 0)),
    Funcion(id: 3,
        peliculaId: 1,
        salaId: 3,
        fechahora: DateTime(2024, 4, 25, 21, 25, 0)),
  ];

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

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();

  }

  YoutubePlayerController get controller => _controller;

  List<Map<String, dynamic>> getFechasFiltradas(Pelicula pelicula) {
    List<Funcion> funcionesFiltradas = funciones.where((funcion) =>
    funcion.peliculaId == pelicula.id).toList();

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
      diaSemana =  diaSemana[0].toUpperCase() + diaSemana.substring(1);
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

  List<Map<String, dynamic>> getFuncionesPorFecha(Pelicula pelicula, DateTime fecha) {
    List<Funcion> funcionesFiltradas = funciones.where((funcion) =>
    funcion.peliculaId == pelicula.id &&
        DateTime(funcion.fechahora.year, funcion.fechahora.month,
            funcion.fechahora.day) == fecha
    ).toList();

    Map<int, List<Funcion>> funcionesPorSala = {};
    funcionesFiltradas.forEach((funcion) {
      if (!funcionesPorSala.containsKey(funcion.salaId)) {
        funcionesPorSala[funcion.salaId] = [];
      }
      funcionesPorSala[funcion.salaId]!.add(funcion);
    });

    List<Map<String, dynamic>> funcionesFormateadas = [];
    funcionesPorSala.forEach((salaId, funcionesSala) {
      Sala sala = salas.firstWhere((sala) => sala.id == salaId);
      funcionesFormateadas.add({
        'sala': sala.nombre,
        'funciones': funcionesSala.map((funcion) =>
        {
          'horario': DateFormat('HH:mm').format(funcion.fechahora),
        }).toList(),
      });
    });

    return funcionesFormateadas;
  }

  Rx<DateTime> selectedDate = DateTime(2024, 4, 23, 15, 30, 0).obs;
  RxList<Map<String, dynamic>> funcionesFiltradas = <Map<String, dynamic>>[].obs;
}
