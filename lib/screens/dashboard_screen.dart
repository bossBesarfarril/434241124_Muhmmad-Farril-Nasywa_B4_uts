import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';
import 'create_tiket_screen.dart';
import 'profile_screen.dart';
import 'admin_manage_screen.dart';
import 'notification_screen.dart';
import 'history_screen.dart'; // Import halaman riwayat
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data statistik dari provider secara dinamis (FR-008)
    final ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF263238),
        actions: [
          // Ikon Notifikasi (FR-007)
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (_) => const NotificationScreen())
            ),
          ),
          // Ikon Logout (FR-002)
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () => Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (_) => const LoginScreen())
            ),
          ),
        ],
      ),
      body: SingleChildScrollView( // Tambahkan scroll agar aman di layar kecil
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Area Statistik Tiket (FR-008)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF263238), 
                borderRadius: BorderRadius.circular(16)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem("${ticketProvider.totalTickets}", "Total Tiket"),
                  _buildStatItem("${ticketProvider.pendingTickets}", "Pending"),
                  _buildStatItem("${ticketProvider.resolvedTickets}", "Selesai"),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Menu 1: Panel Manajemen Admin (FR-006)
            ListTile(
              leading: const Icon(Icons.admin_panel_settings_outlined),
              title: const Text("Panel Manajemen (Admin)"),
              subtitle: const Text("Update status dan assign tiket"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => const AdminManageScreen())
              ),
            ),
            const Divider(),

            // Menu 2: Riwayat & Tracking (FR-010 & FR-011)
            ListTile(
              leading: const Icon(Icons.history_outlined),
              title: const Text("Riwayat & Tracking"),
              subtitle: const Text("Cek progres penanganan tiketmu"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => const HistoryScreen())
              ),
            ),
            const Divider(),

            // Menu 3: Profil Saya
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text("Profil Saya"),
              subtitle: const Text("Pengaturan akun dan informasi pribadi"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => const ProfileScreen())
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => const CreateTiketScreen())
        ),
        backgroundColor: const Color(0xFF263238),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Fungsi pembantu untuk membangun item statistik
  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value, 
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)
        ),
        Text(
          label, 
          style: const TextStyle(color: Colors.white70, fontSize: 12)
        ),
      ],
    );
  }
}