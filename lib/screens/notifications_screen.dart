import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notifications_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<NotificationsProvider>();
    final items = prov.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        actions: [
          if (prov.unreadCount > 0)
            TextButton(
              onPressed: prov.markAllRead,
              child: const Text(
                'Marcar tudo lido',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('Sem notificações.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final n = items[i];
                return ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: Icon(
                    n.read
                        ? Icons.notifications_none
                        : Icons.notifications_active,
                    color: n.read ? Colors.grey : Colors.orange,
                  ),
                  title: Text(
                    n.title,
                    style: TextStyle(
                      fontWeight: n.read ? FontWeight.w500 : FontWeight.w700,
                    ),
                  ),
                  subtitle: n.body == null ? null : Text(n.body!),
                  trailing: n.read
                      ? null
                      : const Icon(Icons.fiber_new, color: Colors.red),
                  onTap: () {
                    prov.markRead(n.id);
                  },
                );
              },
            ),
    );
  }
}
