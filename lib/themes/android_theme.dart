import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData projectTheme() => ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.purpleAccent,
      fontFamily: 'JosefinSans',
      appBarTheme: AppBarTheme(
        elevation: 6,
//        iconTheme: IconThemeData(
//          color: Colors.white,
//        ),
        textTheme: TextTheme(
          title: GoogleFonts.libreFranklin(
            textStyle: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          display1: GoogleFonts.libreFranklin(
            textStyle: TextStyle(color: Colors.purple, fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          ),
          display2: GoogleFonts.libreFranklin(
            textStyle: TextStyle(color: Colors.purple, fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          ),
          display3: GoogleFonts.libreFranklin(
            textStyle: TextStyle(color: Colors.purple, fontSize: 48, fontWeight: FontWeight.w500, letterSpacing: 0),
          ),
          display4: GoogleFonts.libreFranklin(
            textStyle: TextStyle(color: Colors.purple, fontSize: 34, fontWeight: FontWeight.w500, letterSpacing: 0.25),
          ),
          headline: GoogleFonts.josefinSans(
            textStyle: TextStyle(color: Colors.purple, fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0),
          ),
          body1: GoogleFonts.josefinSans(
            textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.5),
          ),
          body2: GoogleFonts.josefinSans(
            textStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.25),
          ),
          caption: GoogleFonts.josefinSans(
            textStyle: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.4),
          ),
          overline: GoogleFonts.libreFranklin(
            textStyle: TextStyle(color: Colors.purple, fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 1.5),
          ),
          subtitle: GoogleFonts.josefinSans(
            textStyle: TextStyle(color: Colors.black38, fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 0.2),
          ),
          subhead: GoogleFonts.josefinSans(
            textStyle: TextStyle(color: Colors.purple, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.1),
          ),
          button: GoogleFonts.josefinSans(
            textStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1.25),
          ),
        ),
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
        elevation: 6,
        margin: EdgeInsets.all(10),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(),
        modalElevation: 10,
        modalBackgroundColor: Colors.white,
      ),
    );

class ThemeColors {
  static final primary = Colors.purple;
  static final primaryLight = Colors.purple[200];
  static final primaryDark = Colors.purple[800];
  static final secondary = Colors.purpleAccent;
  static final secondaryLight = Colors.purpleAccent[200];
  static final secondaryDark = Colors.purpleAccent[800];
  static final accent = Colors.amber;
  static final accentLight = Colors.amber[200];
  static final accentDark = Colors.amber[800];
  static final primaryText = Colors.white;
  static final secondaryText = Colors.black;
  static final secondaryTextLight = Colors.black26;
  static final accentText = ThemeColors.accent;
  static final primaryBackground = Colors.white;
  static final secondaryBackground = ThemeColors.accent;
  static final dark = Colors.black54;
  static final black = Colors.black;
}
