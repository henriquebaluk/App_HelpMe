import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationsProvider extends ChangeNotifier {
  final List<AppNotification> _items = [
    AppNotification(
      id: '1',
      title: 'Novo pedido perto de você',
      body: '“Troca de lâmpada” a 1,2 km.',
      date: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    AppNotification(
      id: '2',
      title: 'Obrigado pela ajuda!',
      body: 'Seu apoio foi avaliado com 5 estrelas.',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  List<AppNotification> get items => List.unmodifiable(_items);
  int get unreadCount => _items.where((n) => !n.read).length;

  void add(AppNotification n) {
    _items.insert(0, n);
    notifyListeners();
  }

  void markRead(String id) {
    final i = _items.indexWhere((e) => e.id == id);
    if (i != -1 && !_items[i].read) {
      _items[i].read = true;
      notifyListeners();
    }
  }

  void markAllRead() {
    var changed = false;
    for (final n in _items) {
      if (!n.read) {
        n.read = true;
        changed = true;
      }
    }
    if (changed) notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
