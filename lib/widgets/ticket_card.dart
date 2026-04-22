import 'package:flutter/material.dart';
import '../models/ticket_model.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback onTap;

  const TicketCard({super.key, required this.ticket, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        title: Text(ticket.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(ticket.id),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getStatusColor(ticket.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            ticket.status,
            style: TextStyle(color: _getStatusColor(ticket.status), fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status == 'Pending') return Colors.orange;
    if (status == 'In Progress') return Colors.blue;
    return Colors.green;
  }
}