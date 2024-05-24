import 'package:cineulima/models/entities/Pelicula.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../configs/constants.dart';
import '../../models/entities/Funcion.dart';
import '../../models/entities/Sala.dart';

class CineInfoController extends GetxController {

  void init(){
    initializeDateFormatting('es');
  }


  List<Map<String, dynamic>> getFechasFiltradas(Sala sala) {
    List<Funcion> funcionesFiltradas = FUNCIONES.where((funcion) =>
    funcion.salaId == sala.id).toList();

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

  List<Map<String, dynamic>> getFuncionesPorFecha(Sala sala, DateTime fecha) {
    List<Funcion> funcionesFiltradas = FUNCIONES.where((funcion) =>
    funcion.salaId == sala.id &&
        DateTime(funcion.fechahora.year, funcion.fechahora.month,
            funcion.fechahora.day) == fecha
    ).toList();

    funcionesFiltradas.sort((a, b) => a.fechahora.compareTo(b.fechahora));

    Map<int, List<Funcion>> funcionesPorPelicula = {};
    funcionesFiltradas.forEach((funcion) {
      if (!funcionesPorPelicula.containsKey(funcion.peliculaId)) {
        funcionesPorPelicula[funcion.peliculaId] = [];
      }
      funcionesPorPelicula[funcion.peliculaId]!.add(funcion);
    });

    List<Map<String, dynamic>> funcionesFormateadas = [];
    funcionesPorPelicula.forEach((peliculaId, funcionesPelicula) {
      Pelicula pelicula = PELICULAS.firstWhere((p) => p.id == peliculaId);
      funcionesFormateadas.add({
        'pelicula': pelicula.titulo,
        'imagenUrl': pelicula.imagenUrl,
        'funciones': funcionesPelicula.map((funcion) => {
          "funcion": funcion,
          'horario': DateFormat('HH:mm').format(funcion.fechahora),
        }).toList(),
      });
    });

    return funcionesFormateadas;
  }
  Rx<DateTime> selectedDate = DateTime(2024, 4, 23, 15, 30, 0).obs;
  RxList<Map<String, dynamic>> funcionesFiltradas = <Map<String, dynamic>>[].obs;
}
