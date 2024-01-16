import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData _appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    inputDecorationTheme: _getInputDecorationTheme(),
    outlinedButtonTheme: _getOutlinedButtonTheme(),
    appBarTheme: _getAppBarTheme(),
  );

  static AppBarTheme _getAppBarTheme() {
    return const AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    );
  }

  static InputDecorationTheme _getInputDecorationTheme() {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
    );
  }

  static OutlinedButtonThemeData _getOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  static ThemeData getTheme() {
    return _appTheme;
  }
}
