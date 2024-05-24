import 'package:get/get.dart';

import '../models/entities/Entrada.dart';
import '../models/entities/Funcion.dart';
import '../models/entities/Pelicula.dart';
import '../models/entities/Usuario.dart';
import '../models/entities/Sala.dart';

final List<Pelicula> PELICULAS = [
  Pelicula(
      id: 1,
      titulo: "The Grudge",
      sinopsis:
          "The Grudge is a 2020 American psychological supernatural horror film written and directed by Nicolas Pesce. Originally announced as a reboot of the 2004 American remake and the original 2002 Japanese horror film Ju-On: The Grudge, the film ended up taking place before and during the events of the 2004 film and its two direct sequels, and is the fourth installment in the American The Grudge film series. The film stars Andrea Riseborough, Demián Bichir, John Cho, Betty Gilpin, Lin Shaye, and Jacki Weaver, and follows a police officer who investigates several murders that are seemingly connected to a single house.",
      imagenUrl:
          "https://cdn11.bigcommerce.com/s-twbzkv97cv/images/stencil/1280x1280/products/6001/9197/The_Grudge__51602.1580946628.jpg?c=2",
      trailerUrl: "https://www.youtube.com/watch?v=SxcDo12DvNY",
      actores: [
        "Andrea Riseborough",
        "Demián Bichir",
        "John Cho",
        "Betty Gilpin",
        "Lin Shaye",
        "Jacki Weaver"
      ],
      generos: [
        "Horror",
        "Supernatural"
      ]),
  Pelicula(
      id: 2,
      titulo: "Underwater",
      sinopsis:
          "Underwater is a 2020 American science fiction action horror film directed by William Eubank. The film stars Kristen Stewart, Vincent Cassel, Jessica Henwick, John Gallagher Jr., Mamoudou Athie, and T.J. Miller.",
      imagenUrl:
          "https://m.media-amazon.com/images/M/MV5BNzM0OGZiZWItYmZiNC00NDgzLTg1MjMtYjM4MWZhOGZhMDUwXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg",
      trailerUrl: "https://www.youtube.com/watch?v=acDsd8iX4x4",
      actores: [
        "Kristen Stewart",
        "Vincent Cassel",
        "Jessica Henwick",
        "John Gallagher Jr.",
        "Mamoudou Athie",
        "T.J. Miller"
      ],
      generos: [
        "Action",
        "Horror",
        "Science Fiction"
      ]),
  Pelicula(
      id: 3,
      titulo: "Like a Boss",
      sinopsis:
          "Like a Boss is a 2020 American comedy film directed by Miguel Arteta, written by Sam Pitman and Adam Cole-Kelly, and starring Tiffany Haddish, Rose Byrne, and Salma Hayek. The plot follows two friends who attempt to take back control of their cosmetics company from an industry titan.",
      imagenUrl: "https://m.media-amazon.com/images/M/MV5BNjAyZDRjMjQtODE3MC00ODI2LTgxODktZThjYTgzZDE5NTc4XkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_FMjpg_UX1000_.jpg",
      trailerUrl: "https://www.youtube.com/watch?v=9ESkyRFEso4",
      actores: ["Tiffany Haddish", "Rose Byrne", "Salma Hayek"],
      generos: ["Comedy"]),
  Pelicula(
      id: 4,
      titulo: "The Grudge",
      sinopsis:
          "The Grudge is a 2020 American psychological supernatural horror film written and directed by Nicolas Pesce. Originally announced as a reboot of the 2004 American remake and the original 2002 Japanese horror film Ju-On: The Grudge, the film ended up taking place before and during the events of the 2004 film and its two direct sequels, and is the fourth installment in the American The Grudge film series. The film stars Andrea Riseborough, Demián Bichir, John Cho, Betty Gilpin, Lin Shaye, and Jacki Weaver, and follows a police officer who investigates several murders that are seemingly connected to a single house.",
      imagenUrl:
          "https://image.tmdb.org/t/p/original/vN7JHlHOT9rHNDU27tfYqhABBj5.jpg",
      trailerUrl: "https://www.youtube.com/watch?v=SxcDo12DvNY",
      actores: [
        "Andrea Riseborough",
        "Demián Bichir",
        "John Cho",
        "Betty Gilpin",
        "Lin Shaye",
        "Jacki Weaver"
      ],
      generos: [
        "Horror",
        "Supernatural"
      ]),
  Pelicula(
      id: 5,
      titulo: "Underwater",
      sinopsis:
          "Underwater is a 2020 American science fiction action horror film directed by William Eubank. The film stars Kristen Stewart, Vincent Cassel, Jessica Henwick, John Gallagher Jr., Mamoudou Athie, and T.J. Miller.",
      imagenUrl:
          "https://m.media-amazon.com/images/M/MV5BNzM0OGZiZWItYmZiNC00NDgzLTg1MjMtYjM4MWZhOGZhMDUwXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg",
      trailerUrl: "https://www.youtube.com/watch?v=acDsd8iX4x4",
      actores: [
        "Kristen Stewart",
        "Vincent Cassel",
        "Jessica Henwick",
        "John Gallagher Jr.",
        "Mamoudou Athie",
        "T.J. Miller"
      ],
      generos: [
        "Action",
        "Horror",
        "Science Fiction"
      ]),
  Pelicula(
      id: 6,
      titulo: "Like a Boss",
      sinopsis:
          "Like a Boss is a 2020 American comedy film directed by Miguel Arteta, written by Sam Pitman and Adam Cole-Kelly, and starring Tiffany Haddish, Rose Byrne, and Salma Hayek. The plot follows two friends who attempt to take back control of their cosmetics company from an industry titan.",
      imagenUrl: "https://m.media-amazon.com/images/M/MV5BNjAyZDRjMjQtODE3MC00ODI2LTgxODktZThjYTgzZDE5NTc4XkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_FMjpg_UX1000_.jpg",
      trailerUrl: "https://www.youtube.com/watch?v=9ESkyRFEso4",
      actores: ["Tiffany Haddish", "Rose Byrne", "Salma Hayek"],
      generos: ["Comedy"])
];
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
