import 'package:flutter/material.dart';
import 'package:oraboros/components/button.dart';
import 'package:oraboros/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _handleSignout() async {
    return supabase.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            CustomButtonWidget(
              child: const Center(
                child: Text("signout"),
              ),
              onTap: () {
                _handleSignout().then(
                  (value) =>
                      Navigator.of(context).pushReplacementNamed("/auth"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
