import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Colors.white, // White app bar
    iconTheme: IconThemeData(color: Colors.black), // Black icons in app bar
    elevation: 0.0, // No shadow
  ),
  textTheme: GoogleFonts.openSansTextTheme().apply(
    bodyColor: Colors.black, // Black text
    displayColor: Colors.black, // Black text
  ),
  primaryColor: Colors.white, // White as primary color
  primaryColorDark: Colors.white, // White as primary dark color
  primaryColorLight: Colors.white, // White as primary light color
  scaffoldBackgroundColor: Colors.white, // White background color

  colorScheme: const ColorScheme.light(
    primary: Colors.white, // White as primary color
    onPrimary: Colors.black, // Black text on white background
    secondary: Colors.white, // White as secondary color
    onSecondary: Colors.black, // Black text on secondary color
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black, // Text color
      backgroundColor: Colors.transparent, // Transparent background
    ).copyWith(
      // Adding only the bottom border
      side: MaterialStateProperty.all(
        const BorderSide(color: Colors.black, width: 1.0),
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Color.fromARGB(255, 12, 12, 12),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: Colors.white, color: Colors.black),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.resolveWith((states) => Colors.white),
    fillColor: MaterialStateProperty.resolveWith(
      (states) => states.contains(MaterialState.selected) ? Colors.black : null,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black, // This sets the global cursor color
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2.0),
    ),
    labelStyle: TextStyle(color: Colors.black), // Black input text
  ),
);
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF6F6F6F), // Grey as primary color
  primaryColorDark: Colors.black, // Black as primary dark color
  primaryColorLight:
      const Color(0xFF8F8F8F), // Light grey as primary light color
  scaffoldBackgroundColor:
      const Color(0xFF303030), // Dark grey background color
  textTheme: GoogleFonts.openSansTextTheme().apply(
    bodyColor: Colors.white, // White text
    displayColor: Colors.white, // White text
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF303030), // Grey app bar
    iconTheme: IconThemeData(color: Colors.white), // White icons in app bar
    elevation: 0.0, // No shadow
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF6F6F6F), // Grey as primary color
    onPrimary: Colors.white, // White text on grey background
    secondary: Color(0xFF7F7F7F), // Light grey as secondary color
    onSecondary: Colors.white, // White text on light grey background
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white, // Text color
      backgroundColor: Colors.transparent, // Transparent background
    ).copyWith(
      // Adding only the bottom border
      side: MaterialStateProperty.all(
        const BorderSide(color: Colors.grey, width: 1.0),
      ),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    circularTrackColor: Color(0xFF6F6F6F),
    color: Colors.white, // White progress indicator
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.resolveWith(
        (states) => const Color(0xFF6F6F6F)), // Grey check
    fillColor: MaterialStateProperty.resolveWith(
      (states) => states.contains(MaterialState.selected)
          ? Colors.white
          : null, // White background
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white, // White cursor
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 2.0),
    ),
    labelStyle: TextStyle(color: Colors.white), // White input text
  ),
);
