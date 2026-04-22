import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';

class AdminManageScreen extends StatelessWidget {
  const AdminManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = Provider.of<TicketProvider>(context).tickets;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manajemen Tiket (Admin)"),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF263238),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tickets.length,
        itemBuilder: (ctx, i) {
          final ticket = tickets[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ticket.id, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(ticket.status, style: const TextStyle(color: Colors.blueGrey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(ticket.title, style: const TextStyle(fontSize: 18)),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // FR-006 Point 4: Assign (Simulasi)
                      TextButton.icon(
                        onPressed: () {}, 
                        icon: const Icon(Icons.person_add_alt, size: 18),
                        label: const Text("Assign"),
                      ),
                      const SizedBox(width: 8),
                      // FR-006 Point 3: Update Status
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<TicketProvider>(context, listen: false)
                              .updateStatus(ticket.id, "Resolved");
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF263238), foregroundColor: Colors.white),
                        child: const Text("Set Resolved"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}