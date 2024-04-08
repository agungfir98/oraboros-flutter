import 'package:flutter/material.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:oraboros/screens/auth.screen.dart';
import 'package:oraboros/screens/dashboard/dashboard.screen.dart';
import 'package:oraboros/screens/settings.screen.dart';
import 'package:oraboros/screens/splash.screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xlalwccmjrbsezrtipxv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhsYWx3Y2NtanJic2V6cnRpcHh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTIxNTg0NTksImV4cCI6MjAyNzczNDQ1OX0.ebC0ayoHqovnlr_OEP5hQvHr4D2HWeweIA2nBl6KkbM',
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ],
    child: const MyApp(),
  ));
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
        "/auth": (context) => const Authpage(),
        "/settings": (context) => const SettingsScreen()
      },
      title: 'Oraboros',
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(color: Colors.red),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color.fromARGB(255, 29, 37, 48),
            fontFamily: "Abril",
          ),
          displayMedium: TextStyle(
            color: Color.fromARGB(255, 29, 37, 48),
            fontFamily: 'Lexend',
          ),
          headlineLarge: TextStyle(
            color: Color.fromARGB(255, 29, 37, 48),
            fontSize: 24,
            fontFamily: "Lexend",
          ),
          headlineMedium: TextStyle(
            color: Color.fromARGB(255, 29, 37, 48),
            fontSize: 20,
            fontFamily: "Lexend",
          ),
          headlineSmall: TextStyle(
            color: Color.fromARGB(255, 29, 37, 48),
            fontSize: 16,
            fontFamily: "Lexend",
          ),
          bodyLarge: TextStyle(
            color: Color.fromARGB(255, 29, 37, 48),
            fontSize: 20,
            fontFamily: "Lexend",
          ),
          bodyMedium: TextStyle(
              color: Color.fromARGB(255, 29, 37, 48),
              fontFamily: "Lexend",
              fontSize: 16),
          bodySmall: TextStyle(
            color: Color.fromARGB(255, 29, 37, 48),
            fontSize: 12,
            fontFamily: "Lexend",
          ),
          titleSmall: TextStyle(
            color: Color.fromARGB(255, 29, 37, 48),
            fontSize: 10,
            fontFamily: "Lexend",
          ),
        ),
        useMaterial3: true,
      ),
    );
  }
}
