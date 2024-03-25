import 'package:flutter/material.dart';
import 'package:oraboros/components/button.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Text("Oraboros"),
          CustomButtonWidget(
            child: const Center(
              child: Text("Sign in with Google"),
            ),
            onTap: () {
              print("hehe");
            },
          )
        ],
      )),
    );
  }
}
