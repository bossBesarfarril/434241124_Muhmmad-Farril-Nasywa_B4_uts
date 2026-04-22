import 'package:flutter/material.dart';
import '../models/ticket_model.dart';

class DetailTiketScreen extends StatefulWidget {
  final Ticket ticket;
  const DetailTiketScreen({super.key, required this.ticket});

  @override
  State<DetailTiketScreen> createState() => _DetailTiketScreenState();
}

class _DetailTiketScreenState extends State<DetailTiketScreen> {
  final _commentController = TextEditingController();
  final List<String> _comments = ["Tiket telah diterima oleh sistem."];

  void _sendComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.add(_commentController.text);
        _commentController.clear();
      });
    }
  }

  // Fungsi pembantu untuk membuat UI Tracking (FR-011)
  Widget _buildTrackingStep(String title, String desc, bool isDone) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isDone ? Icons.check_circle : Icons.radio_button_unchecked, 
              color: isDone ? Colors.green : Colors.grey, 
              size: 20
            ),
            Container(width: 2, height: 30, color: Colors.grey.shade300),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: isDone ? Colors.black : Colors.grey
                )
              ),
              Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ticket.id),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF263238),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.ticket.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Status: ${widget.ticket.status}", style: const TextStyle(color: Colors.blueGrey)),
                  const Divider(height: 32),
                  
                  const Text("Deskripsi:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.ticket.description),
                  const SizedBox(height: 32),

                  // IMPLEMENTASI FR-011: Tracking Tiket
                  const Text("Tracking Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildTrackingStep("Tiket Dibuat", "User telah mengirimkan laporan.", true),
                  _buildTrackingStep("Diproses Helpdesk", "Tiket sedang dianalisis oleh tim IT.", widget.ticket.status != 'Pending'),
                  _buildTrackingStep("Selesai", "Masalah telah teratasi.", widget.ticket.status == 'Resolved'),
                  
                  const SizedBox(height: 16),
                  const Text("Komentar & Balasan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._comments.map((c) => Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(c, style: const TextStyle(fontSize: 14)),
                      leading: const Icon(Icons.message_outlined, size: 20),
                    ),
                  )),
                ],
              ),
            ),
          ),
          
          // Fitur Memberikan Komentar/Reply (FR-005 Poin 5)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white, 
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1), // Perbaikan typo titik dua
                  blurRadius: 10
                )
              ]
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: "Tulis balasan...", 
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF263238)), 
                    onPressed: _sendComment
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}