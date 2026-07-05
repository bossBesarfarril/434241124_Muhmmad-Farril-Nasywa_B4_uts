import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'profile_screen.dart'; // Biar semua role bisa akses profil

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    // KONDISI PEMISAHAN TAMPILAN BERDASARKAN ROLE
    if (auth.userRole == "Admin") {
      return _buildAdminDashboard(context, auth.userName);
    } else if (auth.userRole == "Helpdesk") {
      return _buildHelpdeskDashboard(context, auth.userName);
    } else {
      return _buildUserDashboard(context, auth.userName);
    }
  }

  // ================= TAMPILKAN 1: DASHBOARD ADMIN =================
  Widget _buildAdminDashboard(BuildContext context, String name) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Admin"), actions: _profileAction(context)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Selamat Datang, $name", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Hak Akses: Memantau semua tiket & Assign Teknisi IT Support", textAlign: TextAlign.center),
              const SizedBox(height: 30),
              const Card(
                color: Color(0xFF263238),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("PANEL UTAMA ADMIN\n(Fitur FR-006: Tombol Assign Aktif)", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ================= TAMPILKAN 2: DASHBOARD HELPDESK =================
  Widget _buildHelpdeskDashboard(BuildContext context, String name) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Helpdesk / Teknisi"), actions: _profileAction(context)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Halo Teknisi, $name", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
              const SizedBox(height: 10),
              const Text("Hak Akses: Melihat tiket yang ditugaskan ke kamu & klik Set Resolved jika selesai", textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  // ================= TAMPILKAN 3: DASHBOARD USER / MAHASISWA =================
  Widget _buildUserDashboard(BuildContext context, String name) {
    return Scaffold(
      appBar: AppBar(title: const Text("E-Helpdesk Mahasiswa"), actions: _profileAction(context)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Selamat Datang, $name", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Hak Akses: Membuat Tiket Laporan Baru & Cek Riwayat Tracking", textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF263238),
        onPressed: () {}, // Navigasi ke CreateTicketScreen kamu di sini
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Tombol navigasi ke halaman profil yang dipasang di AppBar semua Role
  List<Widget> _profileAction(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.person),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
      )
    ];
  }
}