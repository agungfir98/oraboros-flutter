import 'package:flutter/material.dart';
import 'package:oraboros/components/button.dart';
import 'package:oraboros/components/custom_dialog.dart';
import 'package:oraboros/main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButtonWidget(
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(child: Text("Sign out")),
                      Icon(
                        Icons.logout_outlined,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialogWidget(
                        title: "Sign out",
                        content: const Text(
                            "You are about to be signed out, you sure?"),
                        onOk: () {
                          supabase.auth.signOut().then((value) =>
                              Navigator.of(context).pushReplacementNamed("/"));
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
