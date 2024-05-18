import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/Perfil/perfil_page.dart';

AppBar buildAppBar(String title, context, bool showProfileButton, bool showBackButton) {
  return AppBar(
      leading: showBackButton ? IconButton(
        icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
        onPressed: () {
          Navigator.pop(context);
        },
      ) : null,
      titleSpacing: showBackButton ? 5 : null,
      title: Text(title,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 24),
          )),
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0XFFF26F29),
      actions:   showProfileButton ? [
        IconButton(
          onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PerfilPage()));
            },
          icon: const Icon(Icons.account_circle_rounded,
              color: Colors.white, size: 40),
          tooltip: "Ver perfil",
        )
      ] : []
  );
}