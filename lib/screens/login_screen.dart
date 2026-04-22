import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart'; // Pastikan file ini ada sesuai FR-003
import 'reset_password_screen.dart'; // Pastikan file ini ada sesuai FR-004

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    final email = _emailController.text.trim();
    
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Silakan isi email dahulu")),
      );
      return;
    }

    // Logika Role sesuai email untuk memperbaiki masalah Profil Statis
    if (email.contains('admin')) {
      context.read<AuthProvider>().login("Admin IT Support", "Admin");
    } else {
      context.read<AuthProvider>().login("Budi Santoso", "Mahasiswa");
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "E-Helpdesk",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold, 
                  color: Color(0xFF263238)
                ),
              ),
              const SizedBox(height: 48),
              
              // Input Email
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              
              // Input Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),

              // FITUR LUPA PASSWORD (FR-004)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => const ResetPasswordScreen())
                  ),
                  child: const Text("Lupa Password?"),
                ),
              ),
              
              const SizedBox(height: 16),

              // Tombol Masuk
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF263238),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
                child: const Text("Masuk", style: TextStyle(fontSize: 16)),
              ),
              
              const SizedBox(height: 24),

              // FITUR DAFTAR AKUN (FR-003)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun?"),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (_) => const RegisterScreen())
                    ),
                    child: const Text(
                      "Daftar", 
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}