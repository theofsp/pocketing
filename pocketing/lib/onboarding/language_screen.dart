import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  void _selectLanguage(BuildContext context) {
    // CATATAN: untuk sekarang semua tampilan masih pakai Bahasa Indonesia.
    // Sistem ganti bahasa beneran (ID <-> EN) menyusul di sesi berikutnya.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pilih Bahasa',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFE91E63)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select Language',
                style: TextStyle(fontSize: 16, color: Color(0xFFEC407A)),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _selectLanguage(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE91E63),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Bahasa Indonesia 🇮🇩'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _selectLanguage(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE91E63),
                    side: const BorderSide(color: Color(0xFFE91E63)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('English 🇬🇧'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}