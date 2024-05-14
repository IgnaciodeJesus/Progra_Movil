import 'package:cineulima/pages/carrousel/carrousel_page.dart';
import 'package:cineulima/pages/cines/cines_page.dart';
import 'package:cineulima/pages/movies/movies_page.dart';
import 'package:cineulima/pages/Perfil/perfil_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController control = Get.put(HomeController());
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    CarrouselPage(),
    MoviesPage(),
    CinesPage(),
    PerfilPage()
  ];

  static final List<String> _widgetTitles = <String>[
    'Cine ULima',
    'Películas',
    'Cines',
    'Perfil'
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
      appBar: AppBar(
          title: Text(_widgetTitles[_selectedIndex],
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24),
              )),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0XFFF26F29),
          actions: [
            IconButton(
              onPressed: () {
                if (Get.context != null) {
                  Get.to(() => PerfilPage());
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PerfilPage()));
                }
              },
              icon: const Icon(Icons.account_circle_rounded,
                  color: Colors.white, size: 40),
              tooltip: "Ver perfil",
            )
          ]),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _navigationBottom(),
    );
  }
}
