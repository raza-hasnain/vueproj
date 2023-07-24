import 'package:flutter/material.dart';

class CustomAppTheme {

  var lightBg = const Color(0xFFf5f5f3);
  var darkBg = const Color(0xFF2B2B2B);

  var lightBtn = const Color(0xFF980F13);
  var darkBtn = const Color(0xFFf3edeb);

  var txtFadeBlack = const Color(0xFF2b2b2b);
  var cardDarkRed = const Color(0xFF920804);
  var cardGrey = const Color(0xFF1D1D1D);


  var redDark = const Color(0xFF980F13);
  var redBright = const Color(0xFFD91F26);

  var blackFade = const Color(0xFF2B2B2B);

  // var creamLight = const Color(0xFFf2f3ed);
  // var creamLight = const Color(0xFFeeefe9);
var creamLight = const Color(0xFFeeeeee);

var whatsAppLight = const Color(0xFF58ce63);
var whatsAppDark = const Color(0xFF499c54);




  //region Dark Theme

  var brightnessDark = Brightness.dark;

  // var backgroundDark = const Color(0xFF133465);
  var backgroundDark = Colors.white24;
  var background = const Color(0xFFF3EdEB);

  var colorDarkBlue = const Color(0xFF133465);
  var colorDarkGrey = Colors.black45;
  var colorGrey = const Color(0xFF8C8C8C);
  var colorLightGrey = const Color(0xFFD3D3D3);
  var colorWhite = Colors.white;
  var colorBlack = Colors.black;
  var colorFadeBlack = const Color(0xFF555555);
  var colorOrange = const Color(0xFFFF6700);
  var colorBlue = const Color(0xFF1245a8);


  // FEEDBACK CUSTOM COLOR
  var feedbackClosedDealGreen = const Color(0xFF006F03);
  var feedbackClosedDealBlue = const Color(0xFF133465);
  var feedbackNew = Colors.lightBlueAccent;
  var feedbackMeeting = const Color(0xFF68B532);
  var feedbackFollowUp = Colors.yellow.shade600;
  var feedbackNoAnswer = const Color(0xFFD3D3D3);
  var feedbackLowBudget = Colors.orange;
  var feedbackNotInterested = Colors.red.shade600;
  var feedbackUnreachable = const Color(0xFF949494);




  var primaryDark = ThemeData().primaryColorDark;
  var onPrimaryDark = Colors.white;
// Colors that are not relevant to AppBar in LIGHT mode
  var primaryVariantDark = Colors.white;
  var secondaryDark = Colors.white;
  var secondaryVariantDark = Colors.white;
  var onSecondaryDark = Colors.white;
  // var backgroundDark = Colors.white;
  // var backgroundDark = Colors.grey;
  var headerBackgroundDark = const Color(0xFF133465);
  var headerIconDark = const Color(0xFFD3D3D3);
  var cardWhiteDark = Colors.grey.shade800;
  var textGreyDark = Colors.white;
  var onBackgroundDark = Colors.white;
  var surfaceDark = ThemeData().primaryColorDark;
  var onSurfaceDark = Colors.white;
  var errorDark = Colors.white;
  var onErrorDark = Colors.white;

  //endregion

  //region Light Theme

  var brightness = Brightness.light;
  var primary = ThemeData().primaryColorDark;
  var onPrimary = Colors.white;
  // Colors that are not relevant to AppBar in DARK mode
  var primaryVariant = Colors.grey;
  var secondary = ThemeData().primaryColorDark;
  var secondaryVariant = Colors.grey;
  var onSecondary = Colors.grey;
  // var background = Colors.grey;
  // var background = const Color(0xFFF3EBED);
  var headerBackground = Colors.white;
  var headerIcon = const Color(0xFF133465);
  var cardWhite = Colors.white;
  var textGrey = const Color(0xFF8C8C8C);
  var onBackground = Colors.grey;
  var surface = ThemeData().primaryColorDark;
  var onSurface = Colors.grey;
  var error = Colors.grey;
  var onError = Colors.grey;

  //endregion

  ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        background: background,
        onBackground: onBackground,
        surface: surface,
        onSurface: onSurface,
        error: error,
        onError: onError,
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: brightnessDark,
        primary: primaryDark,
        onPrimary: onPrimaryDark,
        secondary: secondaryDark,
        onSecondary: onSecondaryDark,
        background: backgroundDark,
        onBackground: onBackgroundDark,
        surface: surfaceDark,
        onSurface: onSurfaceDark,
        error: errorDark,
        onError: onErrorDark,
      ),
    );
  }
}
