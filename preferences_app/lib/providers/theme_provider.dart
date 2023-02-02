import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;

  ThemeProvider({required bool isDarkmode})
      : currentTheme = isDarkmode ? ThemeData.dark() : ThemeData.light();

  setLightmode() {
    currentTheme = ThemeData.light();
    notifyListeners();
  }

  setDarkmode() {
    currentTheme = ThemeData.dark();
    notifyListeners();
  }
}
