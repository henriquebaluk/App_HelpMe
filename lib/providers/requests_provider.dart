import 'dart:math';
import 'package:flutter/material.dart';
import '../models/request_model.dart';

class RequestsProvider extends ChangeNotifier {
  final List<RequestModel> _items = [];
  List<RequestModel> get items => List.unmodifiable(_items);

  void seed() {
    if (_items.isNotEmpty) return;

    // Base SP
    const baseLat = -23.5558;
    const baseLng = -46.6396;
    final rand = Random();

    final add =
        (
          String id,
          String title,
          String desc,
          String cat,
          String urg,
          double dist,
        ) {
          _items.add(
            RequestModel(
              id: id,
              title: title,
              description: desc,
              category: cat,
              urgency: urg,
              distanceKm: dist,
              lat: baseLat + (rand.nextDouble() - .5) * 0.03,
              lng: baseLng + (rand.nextDouble() - .5) * 0.03,
              authorEmail: 'demo@helpme.app',
            ),
          );
        };

    add(
      '1',
      'Troca de lâmpada',
      'Preciso de ajuda para trocar uma lâmpada no corredor.',
      'Serviço',
      'Alta',
      0.9,
    );
    add(
      '2',
      'Doação de roupas infantis',
      'Roupas 4 a 8 anos em bom estado.',
      'Doação',
      'Média',
      2.1,
    );
    add(
      '3',
      'Carona até o centro',
      'Saída 8h amanhã, região Vila Mariana.',
      'Transporte',
      'Baixa',
      4.0,
    );
    add(
      '4',
      'Companhia para idoso',
      'Leitura e conversa 1h no período da tarde.',
      'Companhia',
      'Média',
      1.2,
    );

    notifyListeners();
  }

  void add(RequestModel r) {
    _items.insert(0, r);
    notifyListeners();
  }

  List<RequestModel> byAuthor(String email) =>
      _items.where((e) => e.authorEmail == email).toList();

  RequestModel? byId(String id) {
    for (final e in _items) {
      if (e.id == id) return e;
    }
    return null;
  }
}
