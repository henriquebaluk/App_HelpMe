import 'package:flutter/material.dart';
import '../widgets/help_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<Map<String, dynamic>> get _requests => const [
    {
      'title': 'Trocar lâmpada',
      'description': 'Ajuda rápida para trocar a lâmpada do corredor.',
      'category': 'Serviço',
      'distanceKm': 0.5,
      'urgency': 'Alta',
    },
    {
      'title': 'Doação de roupas infantis',
      'description': 'Roupas 6-8 anos para doação.',
      'category': 'Doação',
      'distanceKm': 1.2,
      'urgency': 'Média',
    },
    {
      'title': 'Carona ao posto de saúde',
      'description': 'Consulta às 14h, alguém pode ajudar?',
      'category': 'Transporte',
      'distanceKm': 2.1,
      'urgency': 'Alta',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HelpMe — Pedidos próximos'),
        actions: [
          IconButton(
            tooltip: 'Perfil',
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _requests.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = _requests[index];
          return HelpCard(
            title: item['title'],
            subtitle:
                '${item['category']} • ${item['distanceKm']} km • Urgência: ${item['urgency']}',
            description: item['description'],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Novo pedido'),
        onPressed: () => Navigator.pushNamed(context, '/create'),
      ),
    );
  }
}
