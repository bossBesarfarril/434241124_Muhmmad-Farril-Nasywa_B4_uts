import 'package:flutter/material.dart';
import 'detail_tiket_screen.dart';
import '../providers/ticket_provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Kita ambil data tiket untuk simulasi navigasi ke halaman terkait
    final tickets = Provider.of<TicketProvider>(context).tickets;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi"),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF263238),
      ),
      body: tickets.isEmpty
          ? const Center(child: Text("Belum ada notifikasi baru."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              itemBuilder: (ctx, i) {
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFF1F3F4),
                      child: Icon(Icons.notifications_active, color: Color(0xFF263238), size: 20),
                    ),
                    title: Text(
                      "Update Tiket: ${tickets[i].title}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      "Status tiket ${tickets[i].id} saat ini adalah ${tickets[i].status}.",
                      style: const TextStyle(fontSize: 12),
                    ),
                    onTap: () {
                      // FR-007 Poin 2: Navigasi ke halaman terkait
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailTiketScreen(ticket: tickets[i]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}