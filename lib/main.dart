import 'package:flutter/material.dart';
import 'package:tidal/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tidal',
      theme: ThemeData(
        primaryColor: const Color(0xFF1DFEEE),
        colorScheme: const ColorScheme.light(
          secondary: Color(0xFFFCC477),
        ),
      ),
      home: const MainPage(),
    );
  }
}
