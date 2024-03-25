import 'package:flutter/material.dart';
import 'package:oraboros/screens/auth.dart';
import 'package:oraboros/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const MyHomePage(),
        "/auth": (context) => const Authpage()
      },
      title: 'Oraboros',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
