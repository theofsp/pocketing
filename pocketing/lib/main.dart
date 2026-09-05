import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocketing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // === WARNA BABY PINK + PINK PITA ===
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E63), // Pink pita
          brightness: Brightness.light,
        ).copyWith(
          surface: const Color(0xFFFCE4EC),         // Baby pink background
          primary: const Color(0xFFE91E63),          // Pink pita utama
          onPrimary: Colors.white,                   // Text di atas pink pita
          secondary: const Color(0xFFF48FB1),        // Pink lebih soft
          onSecondary: Colors.white,
          tertiary: const Color(0xFFEC407A),          // Pink accent
        ),
        scaffoldBackgroundColor: const Color(0xFFFCE4EC), // Baby pink
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE91E63),        // Pink pita
          foregroundColor: Colors.white,              // Text putih
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFE91E63),        // Pink pita
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE91E63),
            foregroundColor: Colors.white,
          ),
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 2,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⭐ Pocketing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo area
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE91E63).withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  '⭐',
                  style: TextStyle(fontSize: 60),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // App name
            Text(
              'Pocketing',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle
            Text(
              'Pocket Money: Reward & Punishment Tracker',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            // Test button
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🎉 Tema baby pink berhasil!'),
                    backgroundColor: Color(0xFFE91E63),
                  ),
                );
              },
              icon: const Icon(Icons.palette),
              label: const Text('Test Tema Pink'),
            ),
          ],
        ),
      ),
    );
  }
}