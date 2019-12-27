import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectTheme {
  static final MaterialColor primaryColorSwatch = MaterialColor(0xFF33333d, {
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

  static final ColorScheme primaryColorScheme = ColorScheme(
    primary: ThemeColors.primary,
    primaryVariant: ThemeColors.primaryDark,
    onPrimary: ThemeColors.onPrimary,
    secondary: ThemeColors.secondary,
    secondaryVariant: ThemeColors.secondaryDark,
    onSecondary: ThemeColors.onSecondary,
    surface: ThemeColors.primaryLight,
    onSurface: ThemeColors.primary,
    background: ThemeColors.background,
    onBackground: ThemeColors.onBackground,
    brightness: Brightness.dark,
    error: ThemeColors.error,
    onError: ThemeColors.onError,
  );

  static final ThemeData baseTheme = ThemeData(
    cardTheme: CardTheme(
      elevation: 1,
      color: ThemeColors.dp2,
    ),
    errorColor: ThemeColors.error,
    fontFamily: GoogleFonts.nunito().fontFamily,
    primarySwatch: primaryColorSwatch,
    scaffoldBackgroundColor: ThemeColors.background,
//    accentColor: ThemeColors.secondary,
//    backgroundColor: ThemeColors.primary,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      height: 40,
      minWidth: 150,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      hoverColor: ThemeColors.secondaryDp4,
      buttonColor: ThemeColors.primary,
    ),
    colorScheme: primaryColorScheme,
    appBarTheme: AppBarTheme(
      color: ThemeColors.dp4,
      elevation: 4,
      brightness: Brightness.dark,
    ),
    textTheme: projectTextTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 16,
      backgroundColor: ThemeColors.secondaryDp16,
      hoverElevation: 16,
      hoverColor: ThemeColors.secondaryDp16,
    ),
    dividerTheme: DividerThemeData(
      thickness: 2,
      color: ThemeColors.secondaryDp2,
      space: 15,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ThemeColors.dp4,
      elevation: 4,
      disabledActionTextColor: ThemeColors.secondaryDp4,
      actionTextColor: ThemeColors.secondaryDp4,
      contentTextStyle: projectTextTheme.body1.copyWith(color: ThemeColors.secondaryDp4),
      behavior: SnackBarBehavior.fixed,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: ThemeColors.secondary,
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: EdgeInsets.all(4),
      unselectedLabelColor: ThemeColors.secondaryLight,
    ),
    iconTheme: IconThemeData(
      color: ThemeColors.secondaryDp2,
      size: 25,
    ),
  );

  static ThemeData dark() {
    return baseTheme.copyWith(primaryColor: Color(0xFF33333d));
  }

  static ThemeData light() {
    return baseTheme.copyWith(primaryColor: Color(0xFF52525A));
  }

  static final TextTheme projectTextTheme = TextTheme(
    display1: GoogleFonts.nunito(fontWeight: FontWeight.w300, fontSize: 112, textStyle: defaultTextStyle),
    display2: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 56, textStyle: defaultTextStyle),
    display3: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 45, textStyle: defaultTextStyle),
    display4: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 34, textStyle: defaultTextStyle),
    headline: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 24, textStyle: defaultTextStyle),
    title: GoogleFonts.nunito(fontWeight: FontWeight.w600, fontSize: 20, textStyle: defaultTextStyle),
    subtitle: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 16, textStyle: defaultTextStyle),
    subhead: GoogleFonts.nunito(fontWeight: FontWeight.w600, fontSize: 15, textStyle: defaultTextStyle),
    body2: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 14, textStyle: defaultTextStyle),
    body1: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 14, textStyle: defaultTextStyle),
    button: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 14, textStyle: defaultTextStyle),
    caption: GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 12, textStyle: defaultTextStyle),
    overline: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 12, textStyle: defaultTextStyle),
  );

  static final TextStyle defaultTextStyle = TextStyle(
    color: ThemeColors.onBackground,
  );
}

int calculateAlpha(final double percentage) => 255 - percentOf255(percentage);
int percentOf255(final double percentage) => ((percentage / 100) * 255).round();

class ThemeColors {
  static final primary = Color(0xFF33333d);
  static final onPrimary = Color(0xFFFFFFFF);
  static final primaryLight = Color(0xFF7c7c8d);
  static final primaryDark = Color(0xFF272836);

  static final secondary = Color(0xff08a874);
  static final onSecondary = Color(0xff000000);
  static final secondaryDark = Color(0xff57daa3);
  static final secondaryLight = Color(0xff007848);
  static final chartSecondary = charts.Color(r: 26, g: 186, b: 134);

  static final secondaryDp1 = Color.fromARGB(255, 8 + percentOf255(5), 168 + percentOf255(5), 116 + percentOf255(5));
  static final secondaryDp2 = Color.fromARGB(255, 8 + percentOf255(7), 168 + percentOf255(7), 116 + percentOf255(7));
  static final secondaryDp4 = Color.fromARGB(255, 8 + percentOf255(9), 168 + percentOf255(9), 116 + percentOf255(9));
  static final secondaryDp6 = Color.fromARGB(255, 8 + percentOf255(11), 168 + percentOf255(11), 116 + percentOf255(11));
  static final secondaryDp16 = Color.fromARGB(255, 8 + percentOf255(15), 168 + percentOf255(15), 116 + percentOf255(15));
  static final secondaryDp24 = Color.fromARGB(255, 8 + percentOf255(16), 168 + percentOf255(16), 116 + percentOf255(16));

  static final dp1 = Color(0xff1d1d1d);
  static final dp2 = Color(0xff212121);
  static final dp3 = Color(0xff242424);
  static final dp4 = Color(0xff272727);
  static final dp6 = Color(0xff2c2c2c);
  static final dp8 = Color(0xff2d2d2d);
  static final dp12 = Color(0xff323232);
  static final dp16 = Color(0xff353535);
  static final dp24 = Color(0xff373737);

  static final error = Color(0xffCF6679);
  static final onError = Color(0xff000000);
  static final warning = Color(0xffffdc78);

  static final errorDp16 = Color.fromARGB(255, 207 + percentOf255(15), 102 + percentOf255(15), 121 + percentOf255(15));

  static final scaffoldBackground = ProjectTheme.primaryColorSwatch.shade100;
  static final background = Color(0xff121212);
  static final onBackground = Color(0xffffffff);
}

class Animations {
  static final Tween<Offset> slideInFromBottom = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0));
  static final Tween<Offset> slideInFromTop = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0));
  static final Tween<Offset> slideInFromRight = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0));
  static final Tween<Offset> slideInFromLeft = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0));
}

class Constants {
  static final SizedBox columnSpacer = SizedBox(height: Constants.smallPadding);

  static final double defaultPadding = 15;
  static final EdgeInsets defaultPaddingEdgeInset = EdgeInsets.all(Constants.defaultPadding);

  static final double cardPadding = 20;
  static final EdgeInsets cardPaddingEdgeInset = EdgeInsets.all(Constants.cardPadding);

  static final double smallPadding = 5;
  static final EdgeInsets smallPaddingEdgeInset = EdgeInsets.all(Constants.smallPadding);

  static final double taskStopwatchIconSize = 200;
  static final double taskChartContainerSize = 165;
  static final int taskChartMaxGraphedSprints = 10;
}
