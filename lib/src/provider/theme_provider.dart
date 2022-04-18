import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isLightMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.light;
    } else {
      return themeMode == ThemeMode.light;
    }
  }

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.dark(),
    // iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final lightTheme = ThemeData(
    // scaffoldBackgroundColor: Colors.white,
    // scrollbarTheme: const ScrollbarThemeData(isAlwaysShown: true),
    primaryColor: Colors.white,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme.light(),
    // iconTheme: const IconThemeData(color: Colors.orange, opacity: 0.8),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
