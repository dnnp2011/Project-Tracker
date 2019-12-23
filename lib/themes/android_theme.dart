import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectTheme {
  static final primaryColorSwatch = MaterialColor(0xFF33333d, {
    50: Color(0xFFE7E7E8),
    100: Color(0xFFC2C2C5),
    200: Color(0xFF99999E),
    300: Color(0xFF707077),
    400: Color(0xFF52525A),
    500: Color(0xFF33333d),
    600: Color(0xFF2E2E37),
    700: Color(0xFF27272F),
    800: Color(0xFF202027),
    900: Color(0xFF14141A)
  });

  static final ThemeData baseTheme = ThemeData(
    cardTheme: CardTheme(
      elevation: 4,
    ),
    fontFamily: GoogleFonts.nunito().fontFamily,
    primarySwatch: primaryColorSwatch,
    scaffoldBackgroundColor: Color(0xFF707077),
  );

  static ThemeData dark() {
    return baseTheme.copyWith(primaryColor: Color(0xFF33333d));
  }

  static ThemeData light() {
    return baseTheme.copyWith(primaryColor: Color(0xFF52525A));
  }

  final TextTheme projectTextTheme = TextTheme(
    title: GoogleFonts.libreFranklin(),
    display1: GoogleFonts.libreFranklin(),
    display2: GoogleFonts.libreFranklin(),
    display3: GoogleFonts.libreFranklin(),
    display4: GoogleFonts.libreFranklin(),
    headline: GoogleFonts.josefinSans(),
    body1: GoogleFonts.josefinSans(),
    body2: GoogleFonts.josefinSans(),
    caption: GoogleFonts.josefinSans(),
    overline: GoogleFonts.libreFranklin(),
    subtitle: GoogleFonts.josefinSans(),
    subhead: GoogleFonts.josefinSans(),
    button: GoogleFonts.josefinSans(),
  );
}

/*ThemeData projectTheme() => ThemeData(
      primarySwatch: Colors.amber,
      accentColor: Colors.purpleAccent,
      textTheme: globalTextTheme,
      appBarTheme: AppBarTheme(
        elevation: 6,
        textTheme: globalTextTheme,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 6,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.purple,
        textTheme: ButtonTextTheme.normal,
        splashColor: Colors.purpleAccent,
      ),
      cardTheme: CardTheme(
        color: Colors.white70,
        elevation: 2,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(),
        modalElevation: 10,
        modalBackgroundColor: Colors.white,
      ),
    );*/

class ThemeColors {
  static final primary = Color(0xFF33333d);
  static final onPrimary = Color(0xFFFFFFFF);
  static final primaryLight = Color(0xFF7c7c8d);
  static final primaryDark = Color(0xFF272836);

  static final secondary = Color(0xff08a874);
  static final onSecondary = Color(0xff000000);
  static final secondaryDark = Color(0xff57daa3);
  static final secondaryLight = Color(0xff007848);

  static final alert = Color(0xffff6951);
  static final warning = Color(0xffffdc78);

  static final scaffoldBackground = ProjectTheme.primaryColorSwatch.shade50;

//  static final primaryLight = Colors.purple[200];
//  static final primaryDark = Colors.purple[800];
//  static final secondary = Colors.purpleAccent;
//  static final secondaryLight = Colors.purpleAccent[200];
//  static final secondaryDark = Colors.purpleAccent[800];
//  static final accent = Colors.amber;
//  static final accentLight = Colors.amber[200];
//  static final accentDark = Colors.amber[800];
//  static final primaryText = Colors.white;
//  static final secondaryText = Colors.black;
//  static final secondaryTextLight = Colors.black26;
//  static final accentText = ThemeColors.accent;
//  static final primaryBackground = Colors.white;
//  static final secondaryBackground = ThemeColors.accent;
//  static final dark = Colors.black54;
//  static final black = Colors.black;
//  static final error = Colors.redAccent;
}

class Animations {
  static final Tween<Offset> slideInFromBottom = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0));
  static final Tween<Offset> slideInFromTop = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0));
  static final Tween<Offset> slideInFromRight = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0));
  static final Tween<Offset> slideInFromLeft = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0));
}
