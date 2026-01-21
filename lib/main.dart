import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SoilSmartApp());
}

class SoilSmartApp extends StatelessWidget {
  const SoilSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoilSmart',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
