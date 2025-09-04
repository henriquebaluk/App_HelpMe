class RequestModel {
  final String id;
  final String title;
  final String description;
  final String category; // Serviço, Doação, Transporte, Companhia
  final String urgency; // Alta, Média, Baixa
  final double distanceKm;
  final double lat;
  final double lng;
  final String authorEmail;

  /// Construtor "tolerante":
  /// - Gera `id` se vier nulo.
  /// - Usa 0.0 para distanceKm/lat/lng quando não informados.
  /// - Usa '' para authorEmail quando não informado.
  factory RequestModel({
    String? id,
    required String title,
    required String description,
    required String category,
    required String urgency,
    double? distanceKm,
    double? lat,
    double? lng,
    String? authorEmail,
  }) {
    return RequestModel._internal(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      category: category,
      urgency: urgency,
      distanceKm: distanceKm ?? 0.0,
      lat: lat ?? 0.0,
      lng: lng ?? 0.0,
      authorEmail: authorEmail ?? '',
    );
    // Observação: se você quiser coordenadas reais, preencha lat/lng no momento da criação.
  }

  const RequestModel._internal({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.urgency,
    required this.distanceKm,
    required this.lat,
    required this.lng,
    required this.authorEmail,
  });

  // ---- Utilidades úteis (opcional, mas recomendado) ----

  RequestModel copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? urgency,
    double? distanceKm,
    double? lat,
    double? lng,
    String? authorEmail,
  }) {
    return RequestModel._internal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      urgency: urgency ?? this.urgency,
      distanceKm: distanceKm ?? this.distanceKm,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      authorEmail: authorEmail ?? this.authorEmail,
    );
  }

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id']?.toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? 'Serviço',
      urgency: json['urgency'] ?? 'Média',
      distanceKm: (json['distanceKm'] is num)
          ? (json['distanceKm'] as num).toDouble()
          : null,
      lat: (json['lat'] is num) ? (json['lat'] as num).toDouble() : null,
      lng: (json['lng'] is num) ? (json['lng'] as num).toDouble() : null,
      authorEmail: json['authorEmail'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'urgency': urgency,
    'distanceKm': distanceKm,
    'lat': lat,
    'lng': lng,
    'authorEmail': authorEmail,
  };

  @override
  String toString() =>
      'RequestModel(id: $id, title: $title, category: $category, urgency: $urgency, dist: $distanceKm km)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RequestModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
