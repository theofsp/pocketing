import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/child_service.dart';
import '../onboarding/welcome_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => _loading = true);
    try {
      final GoogleSignInAccount account = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication auth = account.authentication;
      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (mounted) {
        final hasChildren = await ChildService().hasChildren();
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => hasChildren ? const HomeScreen() : const WelcomeScreen()),
          );
        }
      }
    } on GoogleSignInException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('GoogleSignInException — code: ${e.code}, desc: ${e.description ?? "-"}'),
            duration: const Duration(seconds: 8),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('FirebaseAuthException — code: ${e.code}, msg: ${e.message}'), duration: const Duration(seconds: 8)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error lain: $e'), duration: const Duration(seconds: 8)),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
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
              const SizedBox(height: 48),
              _loading
                  ? const CircularProgressIndicator(color: Color(0xFFE91E63))
                  : ElevatedButton.icon(
                      onPressed: _signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFE91E63),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.login),
                      label: const Text('Masuk dengan Google', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}