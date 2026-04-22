import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';

class CreateTiketScreen extends StatefulWidget {
  const CreateTiketScreen({super.key});

  @override
  State<CreateTiketScreen> createState() => _CreateTiketScreenState();
}

class _CreateTiketScreenState extends State<CreateTiketScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool _isFileUploaded = false; // Simulasi status upload

  void _handleSave() {
    if (_titleController.text.isNotEmpty && _descController.text.isNotEmpty) {
      Provider.of<TicketProvider>(context, listen: false)
          .addTicket(_titleController.text, _descController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buat Tiket Baru")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Judul Masalah", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _titleController, decoration: const InputDecoration(hintText: "Contoh: WiFi Mati")),
            const SizedBox(height: 20),
            const Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _descController, maxLines: 4, decoration: const InputDecoration(border: OutlineInputBorder())),
            const SizedBox(height: 20),
            
            // Fitur Upload Laporan (FR-005 Poin 2)
            const Text("Upload Laporan (Gambar/File)", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => setState(() => _isFileUploaded = true),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade50,
                ),
                child: Column(
                  children: [
                    Icon(Icons.cloud_upload_outlined, size: 40, color: _isFileUploaded ? Colors.green : Colors.grey),
                    Text(_isFileUploaded ? "File Berhasil Dipilih" : "Klik untuk Upload dari Kamera/Galeri"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF263238), foregroundColor: Colors.white),
                child: const Text("Kirim Tiket"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}