import 'package:get/get.dart';

import '../../models/entities/Pelicula.dart';

class CarrouselPageController extends GetxController {
  
  List<Pelicula> peliculas = [
    Pelicula(
      id:1,
      titulo: "The Grudge",
      sinopsis: "The Grudge is a 2020 American psychological supernatural horror film written and directed by Nicolas Pesce. Originally announced as a reboot of the 2004 American remake and the original 2002 Japanese horror film Ju-On: The Grudge, the film ended up taking place before and during the events of the 2004 film and its two direct sequels, and is the fourth installment in the American The Grudge film series. The film stars Andrea Riseborough, Demián Bichir, John Cho, Betty Gilpin, Lin Shaye, and Jacki Weaver, and follows a police officer who investigates several murders that are seemingly connected to a single house.",
      imagenUrl: "https://cdn11.bigcommerce.com/s-twbzkv97cv/images/stencil/1280x1280/products/6001/9197/The_Grudge__51602.1580946628.jpg?c=2",
      trailerUrl: "https://www.youtube.com/watch?v=SxcDo12DvNY",
      actores: ["Andrea Riseborough", "Demián Bichir", "John Cho", "Betty Gilpin", "Lin Shaye", "Jacki Weaver"],
      generos: ["Horror", "Supernatural"]
    ),
    Pelicula(
      id: 2,
      titulo: "Underwater",
      sinopsis: "Underwater is a 2020 American science fiction action horror film directed by William Eubank. The film stars Kristen Stewart, Vincent Cassel, Jessica Henwick, John Gallagher Jr., Mamoudou Athie, and T.J. Miller.",
      imagenUrl: "https://m.media-amazon.com/images/M/MV5BNzM0OGZiZWItYmZiNC00NDgzLTg1MjMtYjM4MWZhOGZhMDUwXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg",
      trailerUrl: "",
      actores: ["Kristen Stewart", "Vincent Cassel", "Jessica Henwick", "John Gallagher Jr.", "Mamoudou Athie", "T.J. Miller"],
      generos: ["Action", "Horror", "Science Fiction"]
    ),
    Pelicula(
      id: 3,
      titulo: "Like a Boss",
      sinopsis: "Like a Boss is a 2020 American comedy film directed by Miguel Arteta, written by Sam Pitman and Adam Cole-Kelly, and starring Tiffany Haddish, Rose Byrne, and Salma Hayek. The plot follows two friends who attempt to take back control of their cosmetics company from an industry titan.",
      imagenUrl: "https://m.media-amazon.com/images/M/MV5BNjAyZDRjMjQtODE3MC00ODI2LTgxODktZThjYTgzZDE5NTc4XkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_FMjpg_UX1000_.jpg",
      trailerUrl: "",
      actores: ["Tiffany Haddish", "Rose Byrne", "Salma Hayek"],
      generos: ["Comedy"]
   )
  ];




}
