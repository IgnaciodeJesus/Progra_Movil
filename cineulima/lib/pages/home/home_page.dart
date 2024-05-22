import 'package:cineulima/Widgets/AppBar.dart';
import 'package:cineulima/pages/carrousel/carrousel_page.dart';
import 'package:cineulima/pages/cines/cines_page.dart';
import 'package:cineulima/pages/movies/movies_page.dart';
import 'package:cineulima/pages/Perfil/perfil_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/entities/Usuario.dart';

class HomePage extends StatefulWidget {
  final Usuario usuarioLogged;

  //Constructor
  const HomePage({Key? key, required this.usuarioLogged}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(user: usuarioLogged);
}

class _HomePageState extends State<HomePage> {
  HomeController control = Get.put(HomeController());
  int _selectedIndex = 0;
  final Usuario user;

  _HomePageState({required this.user});

  static final List<Widget> _widgetOptions = <Widget>[
    CarrouselPage(),
    MoviesPage(),
    CinesPage(),
  ];

  static final List<String> _widgetTitles = <String>[
    'Cine ULima',
    'Películas',
    'Cines',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _navigationBottom() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon:
                SvgPicture.asset('assets/svg/home.svg', width: 20, height: 20),
            activeIcon: SvgPicture.asset('assets/svg/home.svg',
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(Color(0XFFF26F29), BlendMode.srcIn)),
            label: 'Inicio'),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svg/peliculas.svg',
              width: 20, height: 20),
          activeIcon: SvgPicture.asset('assets/svg/peliculas.svg',
              width: 20,
              height: 20,
              colorFilter:
                  const ColorFilter.mode(Color(0XFFF26F29), BlendMode.srcIn)),
          label: 'Películas',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svg/salas.svg', width: 20, height: 20),
          activeIcon: SvgPicture.asset('assets/svg/salas.svg',
              width: 20,
              height: 20,
              colorFilter:
                  const ColorFilter.mode(Color(0XFFF26F29), BlendMode.srcIn)),
          label: 'Cines',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0XFFF26F29),
      onTap: _onItemTapped,
      selectedLabelStyle: GoogleFonts.itim(
          textStyle: const TextStyle(fontWeight: FontWeight.w500)),
      unselectedLabelStyle: GoogleFonts.itim(
          textStyle: const TextStyle(fontWeight: FontWeight.w400)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(_widgetTitles[_selectedIndex], context, true, false),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _navigationBottom(),
    );
  }
}
