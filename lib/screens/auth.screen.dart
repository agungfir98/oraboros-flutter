import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oraboros/components/button.dart';
import 'package:oraboros/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  Future<AuthResponse> _googleSignIn() async {
    // Web Client ID that you registered with Google Cloud.
    const webClientId =
        '787307211182-57m8ff43mutj0ioap4uvns9uetk6b3ph.apps.googleusercontent.com';

    // iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '787307211182-q9stv8ul1ipvri97oeg4h0a2qpr1fql8.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "ORABOROS",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  "bare necessity expense tracking for your need",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
            CustomButtonWidget(
              onTap: () {
                _googleSignIn().then((value) => {
                      if (value.session != null)
                        {
                          Navigator.of(context)
                              .pushReplacementNamed("/dashboard")
                        }
                    });
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/google-icon.png',
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Sign in with Google",
                      style: TextStyle(
                        fontFamily: "Lexend",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
