import 'package:flutter/material.dart';
import 'package:oraboros/DTO/profile.dto.dart';
import 'package:oraboros/fetcher/profile.api.dart';
import 'package:oraboros/main.dart';
import 'package:oraboros/providers/profile.provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;
    if (session != null) {
      var profile =
          await getProfileById(GetProfileByEmailDTO(id: session.user.id));
      ProfileDTO profileDTO = ProfileDTO.fromJson(profile);

      Provider.of<ProfileProvider>(context, listen: false).setProfile(
        ProfileDTO(
          display_name: profileDTO.display_name,
          email: profileDTO.email,
          id: profileDTO.id,
          avatar: profileDTO.avatar,
        ),
      );

      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else {
      Navigator.of(context).pushReplacementNamed('/auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text(
                "loading...",
                style: TextStyle(fontSize: 24, fontFamily: "Lexend"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
