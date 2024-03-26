import 'package:flutter/material.dart';
import 'package:oraboros/screens/auth.screen.dart';
import 'package:oraboros/screens/dashboard.screen.dart';
import 'package:oraboros/screens/splash.screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://cqixzlruhkitdqgwalvx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxaXh6bHJ1aGtpdGRxZ3dhbHZ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDEzMzUzMDMsImV4cCI6MjAxNjkxMTMwM30.lTTPfYHxRPDzMrJaGBhAXhpqQln05YxkzpDdiS6G6A4',
  );

  runApp(const MyApp());
}

// It's handy to then extract the Supabase client in a variable for later uses
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const SplashPage(),
        "/dashboard": (context) => const MyHomePage(),
        "/auth": (context) => const Authpage()
      },
      title: 'Oraboros',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color.fromARGB(255, 29, 37, 48),
            fontFamily: "Abril",
          ),
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 29, 37, 48),
            fontFamily: "Lexend",
          ),
        ),
        useMaterial3: true,
      ),
    );
  }
}
