import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../onboarding/language_screen.dart';
import '../onboarding/welcome_screen.dart';
import '../services/child_service.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = FirebaseAuth.instance.currentUser;
    if (!mounted) return;

    if (user == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LanguageScreen()));
      return;
    }

    final hasChildren = await ChildService().hasChildren();
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => hasChildren ? const HomeScreen() : const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFCE4EC),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/mainlogo.png', width: 250),
            ],
          ),
        ),
      ),
    );
  }
}