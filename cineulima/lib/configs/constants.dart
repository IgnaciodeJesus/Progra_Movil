import 'package:get/get.dart';

import '../models/entities/Entrada.dart';
import '../models/entities/Funcion.dart';
import '../models/entities/Pelicula.dart';
import '../models/entities/Usuario.dart';
import '../models/entities/Sala.dart';

const BASE_URL = 'http://192.168.19.73:4567';

final List<Pelicula> PELICULAS = [];
final List<Sala> SALAS = [
  Sala(
      id: 1,
      nombre: "Pabellón F1",
      direccion: "Av. Club Golf los Incas 148, Surco",
      imagenUrl:
          "https://www.ulima.edu.pe/sites/default/files/styles/600x300/public/news/img/ulima_centro-de-bienestar-universitario_600x300.jpg?itok=zkCb_0DH"),
  Sala(
      id: 2,
      nombre: "Pabellón L2",
      direccion: "Jirón Cruz del Sur 15023, Surco",
      imagenUrl:
          "https://www.ulima.edu.pe/sites/default/files/styles/600x300/public/page/gallery/w.jpg?itok=vDEBxmDd"),
  Sala(
      id: 3,
      nombre: "Pabellón N",
      direccion: "Av. Club Golf los Incas 148, Surco",
      imagenUrl:
          "https://www.ulima.edu.pe/sites/default/files/styles/600x300/public/news/img/ulima_para_ranking_1.jpg?itok=-duMkaQJ"),
  Sala(
      id: 4,
      nombre: "Pabellón I1",
      direccion: "Av. Club Golf los Incas 148, Surco",
      imagenUrl:
          "https://www.ulima.edu.pe/sites/default/files/styles/600x300/public/news/img/_mg_5142-hdr-edit.jpg?itok=fFkits6x"),
  Sala(
      id: 5,
      nombre: "Pabellón C",
      direccion: "Manuel Olguin 125, Surco",
      imagenUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLpWX9PZ1tqqFVXWpQin9SvUo1Z-jhOPcEGGURbaDupA&s"),
  Sala(
      id: 6,
      nombre: "Pabellón O1",
      direccion: "Av. Club Golf los Incas 148, Surco",
      imagenUrl:
          "https://orientacion.universia.edu.pe/imgs2011/imagenes/2-2020_10_-2020_10_16_161111@2x.jpg"),
  Sala(
      id: 7,
      nombre: "Pre de Lima",
      direccion: "Las Palmas 199, La Molina",
      imagenUrl:
          "https://orientacion.universia.edu.pe/imgs2011/imagenes/1-2019_10_-2020_10_16_161044@2x.jpg"),
];
// Lista observable de usuarios
RxList<Usuario> USUARIOS = <Usuario>[
  Usuario(
    id: 1,
    nombre: "Juan",
    apellido: "Pérez",
    dni: "12345678",
    correo: "juan.perez@example.com",
    password: "juanperez123",
    fotoPerfil: "",
  ),
  Usuario(
    id: 2,
    nombre: "Pedro",
    apellido: "Sanchez",
    dni: "98765432",
    correo: "pedro.sanchez@example.com",
    password: "pedrosanchez123",
    fotoPerfil: "",
  ),
  Usuario(
    id: 3,
    nombre: "Luis",
    apellido: "Tavero",
    dni: "99999999",
    correo: "luis.tavero@example.com",
    password: "luistavero123",
    fotoPerfil: "",
  ),
].obs; // El método .obs convierte la lista en una RxList
final List<Funcion> FUNCIONES = [
  Funcion(
      id: 1,
      peliculaId: 1,
      salaId: 1,
      fechahora: DateTime(2024, 4, 23, 15, 30, 0)),
  Funcion(
      id: 2,
      peliculaId: 2,
      salaId: 2,
      fechahora: DateTime(2024, 4, 23, 19, 30, 0)),
  Funcion(
      id: 3,
      peliculaId: 3,
      salaId: 3,
      fechahora: DateTime(2024, 4, 23, 16, 0, 0)),
  Funcion(
      id: 4,
      peliculaId: 1,
      salaId: 4,
      fechahora: DateTime(2024, 4, 23, 17, 30, 0)),
  Funcion(
      id: 5,
      peliculaId: 2,
      salaId: 5,
      fechahora: DateTime(2024, 4, 23, 18, 20, 0)),
  Funcion(
      id: 6,
      peliculaId: 3,
      salaId: 6,
      fechahora: DateTime(2024, 4, 23, 20, 30, 0)),
  Funcion(
      id: 7,
      peliculaId: 2,
      salaId: 1,
      fechahora: DateTime(2024, 4, 23, 21, 30, 0)),
  Funcion(
      id: 8,
      peliculaId: 3,
      salaId: 2,
      fechahora: DateTime(2024, 4, 23, 22, 30, 0)),
  Funcion(
      id: 9,
      peliculaId: 2,
      salaId: 1,
      fechahora: DateTime(2024, 4, 24, 15, 30, 0)),
  Funcion(
      id: 10,
      peliculaId: 3,
      salaId: 2,
      fechahora: DateTime(2024, 4, 24, 19, 30, 0)),
  Funcion(
      id: 11,
      peliculaId: 1,
      salaId: 3,
      fechahora: DateTime(2024, 4, 24, 16, 0, 0)),
  Funcion(
      id: 12,
      peliculaId: 2,
      salaId: 1,
      fechahora: DateTime(2024, 4, 25, 14, 30, 0)),
  Funcion(
      id: 13,
      peliculaId: 3,
      salaId: 2,
      fechahora: DateTime(2024, 4, 25, 16, 45, 0)),
  Funcion(
      id: 14,
      peliculaId: 1,
      salaId: 3,
      fechahora: DateTime(2024, 4, 25, 21, 25, 0)),
  Funcion(
      id: 15,
      peliculaId: 2,
      salaId: 1,
      fechahora: DateTime(2024, 4, 23, 14, 0, 0)),
  Funcion(
      id: 16,
      peliculaId: 2,
      salaId: 1,
      fechahora: DateTime(2024, 4, 23, 15, 1, 0)),
];

RxList<Entrada> ENTRADAS = <Entrada>[
  Entrada(
    id: 'ANWNJQKM',
    usuarioId: 1,
    funcionId: 1,
  ),
  Entrada(
    id: 'CCCCCCKM',
    usuarioId: 2,
    funcionId: 12,
  ),
  Entrada(
    id: 'DDDDDDKM',
    usuarioId: 1,
    funcionId: 6,
  ),
].obs;
