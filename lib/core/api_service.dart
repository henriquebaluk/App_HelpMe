import 'dart:async';
import 'dart:math';
import '../models/request_model.dart';

class ApiService {
  Future<List<RequestModel>> fetchRequests({int limit = 20}) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final base = <RequestModel>[
      RequestModel(
        id: '1',
        title: "Ajuda para trocar lâmpada",
        description: "Preciso de alguém para trocar a lâmpada da sala.",
        category: "Serviço",
        urgency: "Alta",
        distanceKm: 1.2,
        lat: -23.5560,
        lng: -46.6390,
        authorEmail: 'maria@example.com',
      ),
      RequestModel(
        id: '2',
        title: "Doação de roupas infantis",
        description: "Tenho roupas em bom estado para doar.",
        category: "Doação",
        urgency: "Média",
        distanceKm: 2.5,
        lat: -23.5585,
        lng: -46.6420,
        authorEmail: 'joao@example.com',
      ),
      RequestModel(
        id: '3',
        title: "Carona até o centro",
        description: "Preciso de carona para o centro amanhã cedo.",
        category: "Transporte",
        urgency: "Baixa",
        distanceKm: 3.8,
        lat: -23.5520,
        lng: -46.6320,
        authorEmail: 'ana@example.com',
      ),
    ];

    if (limit <= base.length) {
      return base.take(limit).toList();
    }

    final rand = Random();
    final out = [...base];
    while (out.length < limit) {
      final i = out.length + 1;
      out.add(
        RequestModel(
          id: '$i',
          title: 'Pedido #$i',
          description: 'Descrição simulada do pedido #$i.',
          category: const [
            'Serviço',
            'Doação',
            'Transporte',
            'Companhia',
          ][rand.nextInt(4)],
          urgency: const ['Alta', 'Média', 'Baixa'][rand.nextInt(3)],
          distanceKm: (rand.nextDouble() * 5) + 0.3,
          lat: -23.5558 + (rand.nextDouble() - .5) * 0.03,
          lng: -46.6396 + (rand.nextDouble() - .5) * 0.03,
          authorEmail: 'demo@helpme.app',
        ),
      );
    }
    return out;
  }
}
