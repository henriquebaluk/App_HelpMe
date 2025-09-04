import 'dart:math';

class RequestModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String urgency;
  final double distanceKm;
  final String requesterName;

  RequestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.urgency,
    required this.distanceKm,
    required this.requesterName,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json, Random rng) {
    final categories = ['Serviço', 'Doação', 'Transporte', 'Companhia'];
    final urgencies = ['Alta', 'Média', 'Baixa'];
    final names = ['Ana', 'Lucas', 'Carla', 'João', 'Marina', 'Pedro', 'Sofia'];

    return RequestModel(
      id: (json['id'] ?? rng.nextInt(9999)).toString(),
      title: (json['title'] ?? 'Pedido').toString().trim(),
      description: (json['body'] ?? 'Ajuda necessária.').toString().trim(),
      category: categories[rng.nextInt(categories.length)],
      urgency: urgencies[rng.nextInt(urgencies.length)],
      distanceKm: (rng.nextDouble() * 4.5 + 0.3),
      requesterName: names[rng.nextInt(names.length)],
    );
  }
}
