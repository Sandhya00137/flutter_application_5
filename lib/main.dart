import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:flutter_application_5/widgets/expenses_app.dart';

var colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(55, 96, 59, 181),
);

var darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // // to lock the orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // // to set our app work in particualr orientaion
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
  runApp(MaterialApp(
    // to apply theme entire app in dark mode
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      cardTheme: const CardTheme().copyWith(
        color: darkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: darkColorScheme.primaryContainer,
            foregroundColor: darkColorScheme.onPrimaryContainer),
      ),
    ),
    // to apply theme entire app in light mode
    theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: colorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorScheme.onPrimaryContainer,
          foregroundColor: colorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: colorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSecondaryContainer,
                  fontSize: 16),
            )),
    themeMode: ThemeMode.system,
    home: const ExpensesApp(),
  ));
  // });
}
