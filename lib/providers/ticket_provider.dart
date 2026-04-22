import 'package:flutter/material.dart';
import '../models/ticket_model.dart';

class TicketProvider with ChangeNotifier {
  final List<Ticket> _tickets = [
    Ticket(
      id: 'TKT-2026-001',
      title: 'Masalah Koneksi WiFi',
      description: 'WiFi di ruang lab sering terputus.',
      status: 'Pending',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  List<Ticket> get tickets => [..._tickets];

  // ============================================================
  // GETTER UNTUK FR-008: STATISTIK TIKET (DIPAKAI DI DASHBOARD)
  // ============================================================
  
  // Menghitung total semua tiket
  int get totalTickets => _tickets.length;

  // Menghitung tiket yang masih 'Pending'
  int get pendingTickets => _tickets.where((t) => t.status == 'Pending').length;

  // Menghitung tiket yang sudah 'Resolved' (Selesai)
  int get resolvedTickets => _tickets.where((t) => t.status == 'Resolved').length;

  // ============================================================

  void addTicket(String title, String desc) {
    final newTicket = Ticket(
      id: 'TKT-2026-00${_tickets.length + 1}',
      title: title,
      description: desc,
      status: 'Pending',
      date: DateTime.now(),
    );
    _tickets.insert(0, newTicket);
    notifyListeners(); // Memberitahu UI untuk update angka statistik
  }

  // Fungsi untuk FR-006: Update Status
  void updateStatus(String id, String newStatus) {
    final index = _tickets.indexWhere((t) => t.id == id);
    if (index >= 0) {
      _tickets[index] = Ticket(
        id: _tickets[index].id,
        title: _tickets[index].title,
        description: _tickets[index].description,
        status: newStatus,
        date: _tickets[index].date,
      );
      notifyListeners(); // Memberitahu UI untuk update angka statistik
    }
  }
}