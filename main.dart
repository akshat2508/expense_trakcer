import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 23, 129, 99));


var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor:const  Color.fromARGB(176, 2, 148, 82),);
void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//  DeviceOrientation.portraitUp,
//   ]).then((fn){
      runApp(
    MaterialApp(
      darkTheme:ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
         elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
            
          ),
        ),
      ) ,
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
           titleLarge: TextStyle(fontWeight: FontWeight.bold,
           color: kColorScheme.onSecondaryContainer,
           fontSize: 16),
        ),
        
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
  }
