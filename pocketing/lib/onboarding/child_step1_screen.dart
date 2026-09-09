import 'package:flutter/material.dart';
import 'child_step2_screen.dart';

class ChildStep1Screen extends StatefulWidget {
  const ChildStep1Screen({super.key});

  @override
  State<ChildStep1Screen> createState() => _ChildStep1ScreenState();
}

class _ChildStep1ScreenState extends State<ChildStep1Screen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedGender;

  void _goNext() {
    if (_nameController.text.trim().isEmpty) {
      _showError('Nama anak belum diisi');
      return;
    }
    if (_selectedGender == null) {
      _showError('Jenis kelamin belum dipilih');
      return;
    }
    if (_ageController.text.trim().isEmpty) {
      _showError('Umur anak belum diisi');
      return;
    }
    final int? age = int.tryParse(_ageController.text.trim());
    if (age == null || age <= 0 || age > 25) {
      _showError('Umur tidak valid');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChildStep2Screen(
          name: _nameController.text.trim(),
          gender: _selectedGender!,
          age: age,
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: const Text('Data Anak (1/2)'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nama Anak', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Contoh: Andi',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Jenis Kelamin', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('Laki-laki'),
              value: 'male',
              groupValue: _selectedGender,
              activeColor: const Color(0xFFE91E63),
              onChanged: (value) => setState(() => _selectedGender = value),
            ),
            RadioListTile<String>(
              title: const Text('Perempuan'),
              value: 'female',
              groupValue: _selectedGender,
              activeColor: const Color(0xFFE91E63),
              onChanged: (value) => setState(() => _selectedGender = value),
            ),
            const SizedBox(height: 16),
            const Text('Umur Anak', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Contoh: 10',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _goNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE91E63),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Lanjut', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}