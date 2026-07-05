import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';
import 'reset_password_screen.dart';

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
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Silakan isi email dan password dahulu")),
      );
      return;
    }

    // SIMULASI 3 AKUN DUMMY BERDASARKAN ROLE
    if (email == 'admin@mail.com' && password == 'admin123') {
      context.read<AuthProvider>().login("Siti Aminah (Super Admin)", "Admin");
    } else if (email == 'helpdesk@mail.com' && password == 'helpdesk123') {
      context.read<AuthProvider>().login("Andi Wijaya (IT Support)", "Helpdesk");
    } else if (email == 'user@mail.com' && password == 'user123') {
      context.read<AuthProvider>().login("Budi Santoso (Mahasiswa)", "User");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email atau password dummy salah!")),
      );
      return;
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
        // Ditambahkan SingleChildScrollView agar layar bisa di-scroll saat keyboard muncul
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
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
                const SizedBox(height: 24),

                // ==========================================
                // KOTAK INFORMASI AKUN DUMMY UNTUK TESTING
                // ==========================================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueGrey.shade200),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Info Akun Testing (Role):",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF263238))
                      ),
                      SizedBox(height: 8),
                      Text("• Admin: admin@mail.com | admin123", style: TextStyle(fontSize: 13)),
                      Text("• Helpdesk: helpdesk@mail.com | helpdesk123", style: TextStyle(fontSize: 13)),
                      Text("• User: user@mail.com | user123", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Input Email
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined)
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
                      prefixIcon: Icon(Icons.lock_outline)
                  ),
                ),

                // Lupa Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResetPasswordScreen())),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Masuk", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 24),

                // Daftar Akun
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun?"),
                    TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                      child: const Text("Daftar", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}