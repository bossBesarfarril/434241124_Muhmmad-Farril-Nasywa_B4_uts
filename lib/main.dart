import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/ticket_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart'; // Pastikan sudah buat file ini
import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TicketProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Provider baru untuk Tema
      ],
      child: const ETicketingApp(),
    ),
  );
}

class ETicketingApp extends StatelessWidget {
  const ETicketingApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendengarkan perubahan status tema dari provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'E-Helpdesk',
      debugShowCheckedModeBanner: false,
      
      // Pengaturan Mode Tema
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      // Tema Terang (Light Mode)
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF263238),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF263238),
        ),
      ),

      // Tema Gelap (Dark Mode) - Memenuhi NFR Usability
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF263238),
        /* Warna scaffold otomatis jadi gelap oleh Flutter 
           tapi kamu bisa sesuaikan di sini */
      ),

      home: const LoginScreen(),
    );
  }
}