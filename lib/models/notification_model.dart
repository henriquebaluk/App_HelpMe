class AppNotification {
  final String id;
  final String title;
  final String? body;
  final DateTime date;
  bool read;

  AppNotification({
    required this.id,
    required this.title,
    this.body,
    DateTime? date,
    this.read = false,
  }) : date = date ?? DateTime.now();
}
