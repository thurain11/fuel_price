// import 'package:hexcolor/hexcolor.dart';

import '../../global.dart';

class BuildThemeData {
  // Color lightPrimaryColor = HexColor('#19bc99');
  // Color darkPrimaryColor = HexColor('#1f9b71');
  // Seed color for both themes
  final Color seedColor = Colors.green;

  // Light Theme
  ThemeData lightTheme(String fontFamily) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      fontFamily: fontFamily,
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: base.colorScheme.surface, // background -> surface
        foregroundColor:
            base.colorScheme.onSurface, // onBackground -> onSurface
        elevation: 0,
      ),
      scaffoldBackgroundColor:
          base.colorScheme.surface, // background -> surface
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(
          color: base.colorScheme.onSurface, // onBackground -> onSurface
          fontSize: 16,
          fontFamily: fontFamily,
        ),
        subtitleTextStyle: TextStyle(
          color: base.colorScheme.onSurface
              .withOpacity(0.7), // onBackground -> onSurface
          fontSize: 14,
          fontFamily: fontFamily,
        ),
      ),
      textTheme: base.textTheme.copyWith(
        bodyMedium: TextStyle(
          fontSize: 15,
          fontFamily: fontFamily,
          color: base.colorScheme.onSurface, // onBackground -> onSurface
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          fontFamily: fontFamily,
          color: base.colorScheme.onSurface, // onBackground -> onSurface
        ),
        headlineMedium: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
          color: base.colorScheme.onSurface, // onBackground -> onSurface
        ),
        headlineSmall: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
          color: base.colorScheme.onSurface, // onBackground -> onSurface
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
          color: base.colorScheme
              .onSurfaceVariant, // Colors.black54 -> onSurfaceVariant ဆို ပိုမိုလိုက်ဖက်တယ်
        ),
        titleSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
          color: base
              .colorScheme.onSurface, // မရှိရင် default ထားပေမဲ့ ထည့်ပေးထားတယ်
        ),
        labelLarge: TextStyle(
          fontSize: 15,
          color: seedColor,
          fontFamily: fontFamily,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: seedColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: seedColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: seedColor,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: seedColor,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: seedColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: seedColor),
        ),
        labelStyle: TextStyle(color: seedColor),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(seedColor),
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // Dark Theme
  ThemeData darkTheme(String fontFamily) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
      fontFamily: fontFamily,
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: base.colorScheme.surface,
        foregroundColor: base.colorScheme.onSurface,
        elevation: 0,
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: TextStyle(
          color: base.colorScheme.onSurface, // usually white in dark mode
          fontSize: 16,
          fontFamily: fontFamily,
        ),
        subtitleTextStyle: TextStyle(
          color: base.colorScheme.onSurface.withOpacity(0.7),
          fontSize: 14,
          fontFamily: fontFamily,
        ),
      ),
      scaffoldBackgroundColor: base.colorScheme.surface,
      textTheme: base.textTheme.copyWith(
        bodyMedium: TextStyle(fontSize: 15, fontFamily: fontFamily),
        bodySmall: TextStyle(fontSize: 14, fontFamily: fontFamily),
        headlineMedium: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        headlineSmall: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
        titleSmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        labelLarge: TextStyle(
          fontSize: 15,
          color: seedColor,
          fontFamily: fontFamily,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: seedColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: seedColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: seedColor,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: seedColor,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: seedColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: seedColor),
        ),
        labelStyle: TextStyle(color: seedColor),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(seedColor),
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// secondary: Color(0xff55624c),
// onSecondary: Color(0xffffffff),
// secondaryContainer: Color(0xffd9e7cb),
// onSecondaryContainer: Color(0xff131f0d),
// tertiary: Color(0xff386667),
// onTertiary: Color(0xffffffff),
// tertiaryContainer: Color(0xffbbebeb),
// onTertiaryContainer: Color(0xff002021),
// error: Color(0xffba1b1b),
// onError: Color(0xffffffff),
// errorContainer: Color(0xffffdad4),
// onErrorContainer: Color(0xff410001),
// outline: Color(0xff74796e),
// background: Color(0xfffdfdf6),
// onBackground: Color(0xff1a1c18),
// surface: Color(0xfffdfdf6),
// onSurface: Color(0xff1a1c18),
// surfaceVariant: Color(0xffdfe4d6),
// onSurfaceVariant: Color(0xff43493e),
// inverseSurface: Color(0xff2f312c),
// onInverseSurface: Color(0xfff1f1ea),
// inversePrimary: Color(0xffEBF5EE),
