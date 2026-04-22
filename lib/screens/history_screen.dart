import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';
import 'detail_tiket_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = Provider.of<TicketProvider>(context).tickets;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat & Tracking"),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF263238),
        elevation: 0,
      ),
      body: tickets.isEmpty
          ? const Center(child: Text("Belum ada riwayat tiket."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(ticket.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ticket.id, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ticket.status == 'Resolved' ? Colors.green.shade50 : Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            ticket.status,
                            style: TextStyle(
                              fontSize: 11, 
                              color: ticket.status == 'Resolved' ? Colors.green : Colors.blueGrey,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailTiketScreen(ticket: ticket)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}