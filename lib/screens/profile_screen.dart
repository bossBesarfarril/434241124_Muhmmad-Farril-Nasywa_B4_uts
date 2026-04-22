import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart'; // Import Provider Tema
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context); // Ambil data tema

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"), 
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          // Foto Profil
          Center(
            child: CircleAvatar(
              radius: 50, 
              backgroundColor: themeProvider.isDarkMode ? Colors.grey[800] : const Color(0xFFF1F3F4), 
              child: Icon(
                Icons.person, 
                size: 50, 
                color: themeProvider.isDarkMode ? Colors.white : const Color(0xFF263238)
              )
            )
          ),
          const SizedBox(height: 16),
          
          // Nama & Role Dinamis
          Text(auth.userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(auth.userRole, style: const TextStyle(color: Colors.blueGrey)),
          
          const Divider(height: 40, indent: 20, endIndent: 20),

          // Informasi Email
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text("Email"),
            subtitle: Text(auth.userRole == "Admin" ? "admin@helpdesk.com" : "budi@student.com"),
          ),

          // FITUR MODE GELAP (NFR 4.2: Usability)
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text("Mode Gelap"),
            subtitle: const Text("Ganti tampilan aplikasi"),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme(); // Panggil fungsi ganti tema
              },
            ),
          ),

          const Spacer(), // Memberikan jarak ke bawah

          // TOMBOL LOGOUT (FR-002)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  auth.logout();
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text("Keluar Akun", style: TextStyle(color: Colors.red)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}