import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';
import '../widgets/ticket_card.dart';
import 'detail_tiket_screen.dart';

class ListTiketScreen extends StatelessWidget {
  const ListTiketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = Provider.of<TicketProvider>(context).tickets;
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Tiket")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tickets.length,
        itemBuilder: (ctx, i) => TicketCard(
          ticket: tickets[i],
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailTiketScreen(ticket: tickets[i]))),
        ),
      ),
    );
  }
}