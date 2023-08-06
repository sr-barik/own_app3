import 'package:flutter/material.dart';
import 'package:own_app3/widget/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 12, 8, 88));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData().copyWith(useMaterial3: true, colorScheme: kColorScheme),
      home: const Expenses(),
    );
  }
}
