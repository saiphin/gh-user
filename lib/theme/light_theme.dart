import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFF0EBBEE)}) => ThemeData(
      fontFamily: 'Roboto',
      useMaterial3: true,
      primaryColor: color,
      secondaryHeaderColor: Color(0xFF1ED7AA),
      disabledColor: Color(0xFFBABFC4),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      errorColor: Color(0xFFE84D4F),
      brightness: Brightness.light,
      hintColor: Color(0xFF9F9F9F),
      cardColor: Colors.white,
      colorScheme: ColorScheme.light(primary: color, secondary: color),
      textButtonTheme:
          TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
    );
