class Ticket {
  final String id;
  final String title;
  final String description;
  final String status; // Pending, In Progress, Resolved
  final DateTime date;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
  });
}