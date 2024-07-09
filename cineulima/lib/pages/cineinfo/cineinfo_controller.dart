import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../services/function_service.dart';
import '../../models/responses/funciones_response.dart';
import '../../models/entities/Sala.dart';

class CineInfoController extends GetxController {
  final FunctionService functionService = FunctionService();
  RxList<FuncionesResponse> funciones = <FuncionesResponse>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxList<Map<String, dynamic>> funcionesFiltradas =
      <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('es');
  }

  Future<void> fetchFuncionesBySalaId(int salaId) async {
    isLoading.value = true;
    funciones.value = await functionService.fetchFunctionsBySalaId(salaId);
    updateFuncionesFiltradas(selectedDate.value);
    isLoading.value = false;
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

  void updateFuncionesFiltradas(DateTime fecha) {
    List<FuncionesResponse> funcionesPorFecha = funciones
        .where((funcion) =>
            DateTime(funcion.fechaHora.year, funcion.fechaHora.month,
                funcion.fechaHora.day) ==
            fecha)
        .toList();
    funcionesPorFecha.sort((a, b) => a.fechaHora.compareTo(b.fechaHora));

    Map<int, List<FuncionesResponse>> funcionesPorPelicula = {};
    funcionesPorFecha.forEach((funcion) {
      if (!funcionesPorPelicula.containsKey(funcion.peliculaId)) {
        funcionesPorPelicula[funcion.peliculaId] = [];
      }
      funcionesPorPelicula[funcion.peliculaId]!.add(funcion);
    });

    List<Map<String, dynamic>> funcionesFormateadas = [];
    funcionesPorPelicula.forEach((peliculaId, funcionesPelicula) {
      funcionesFormateadas.add({
        'peliculaId': peliculaId,
        'funciones': funcionesPelicula
            .map((funcion) => {
                  'funcion': funcion,
                  'horario': DateFormat('HH:mm').format(funcion.fechaHora),
                })
            .toList(),
      });
    });

    funcionesFiltradas.value = funcionesFormateadas;
  }
}
