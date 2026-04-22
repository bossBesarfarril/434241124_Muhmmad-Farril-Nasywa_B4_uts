import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Buat Akun Baru",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF263238)),
            ),
            const SizedBox(height: 8),
            const Text("Silakan isi data diri Anda untuk mendaftar.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),
            const TextField(decoration: InputDecoration(labelText: "Nama Lengkap", border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder())),
            const SizedBox(height: 16),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: "Konfirmasi Password", border: OutlineInputBorder())),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // Kembali ke Login setelah daftar
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF263238),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Daftar Sekarang"),
            ),
          ],
        ),
      ),
    );
  }
}