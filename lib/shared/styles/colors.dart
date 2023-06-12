import 'package:flutter/material.dart';

const Color kDprimaryColor = Color(0xFF06A3DA);
// const Color kDprimaryColor = Colors.blueAccent;
const Color kDsecondaryColor = Color(0xFFEEF9FF);
const Color kDbackgroundColor = Colors.indigo;
// const Color kDbackgroundColor = Color.fromARGB(255, 229, 229, 229);
// const Color myColor = Color.fromRGBO(255, 0, 255, 1.0);
const Color myColor = kDprimaryColor;

MaterialColor myColorSwatch = MaterialColor(
  myColor.value, // Use the value of your const color as the primary color
  <int, Color>{
    50: myColor.withOpacity(0.1),
    100: myColor.withOpacity(0.2),
    200: myColor.withOpacity(0.3),
    300: myColor.withOpacity(0.4),
    400: myColor.withOpacity(0.5),
    500: myColor.withOpacity(0.6),
    600: myColor.withOpacity(0.7),
    700: myColor.withOpacity(0.8),
    800: myColor.withOpacity(0.9),
    900: myColor.withOpacity(1.0),
  },
);