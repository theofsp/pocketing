import 'package:flutter/material.dart';
import '../models/child.dart';
import '../services/child_service.dart';
import '../screens/home_screen.dart';

class ChildStep2Screen extends StatefulWidget {
  final String name;
  final String gender;
  final int age;

  const ChildStep2Screen({
    super.key,
    required this.name,
    required this.gender,
    required this.age,
  });

  @override
  State<ChildStep2Screen> createState() => _ChildStep2ScreenState();
}

class _ChildStep2ScreenState extends State<ChildStep2Screen> {
  final _nominalController = TextEditingController();
  String _currency = 'IDR';
  int _cycleDay = 25;
  bool _saving = false;

  final List<String> _currencies = ['IDR', 'USD', 'KRW', 'CNY', 'INR', 'SGD', 'MYR', 'JPY', 'SAR', 'VND'];

  Future<void> _saveChild() async {
    if (_nominalController.text.trim().isEmpty) {
      _showError('Nominal uang jajan belum diisi');
      return;
    }
    final double? nominal = double.tryParse(_nominalController.text.trim());
    if (nominal == null || nominal <= 0) {
      _showError('Nominal tidak valid');
      return;
    }

    setState(() => _saving = true);
    try {
      final child = Child(
        name: widget.name,
        gender: widget.gender,
        age: widget.age,
        currency: _currency,
        monthlyAllowance: nominal,
        cycleStartDay: _cycleDay,
      );
      await ChildService().addChild(child);

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      _showError('Gagal menyimpan: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: const Text('Data Anak (2/2)'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mata Uang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currency,
                  isExpanded: true,
                  items: _currencies.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (value) => setState(() => _currency = value!),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Nominal Uang Jajan / Bulan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Contoh: 200000',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Tanggal Mulai Cycle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _cycleDay,
                  isExpanded: true,
                  items: List.generate(28, (i) => i + 1).map((d) => DropdownMenuItem(value: d, child: Text('Tanggal $d'))).toList(),
                  onChanged: (value) => setState(() => _cycleDay = value!),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _saveChild,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE91E63),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _saving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Selesai', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}