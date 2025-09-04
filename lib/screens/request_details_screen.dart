import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/request_model.dart';
import '../core/app_theme.dart' show categoryColor;
import '../providers/auth_provider.dart';

class RequestDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RequestModel r =
        ModalRoute.of(context)!.settings.arguments as RequestModel;
    final c = categoryColor(r.category);
    final me = context.read<AuthProvider>().currentUser?.email;

    final isMine = me != null && me == r.authorEmail;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              r.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text(r.category),
                  backgroundColor: c.withOpacity(.12),
                ),
                Chip(label: Text('Urgência: ${r.urgency}')),
                Chip(label: Text('${r.distanceKm.toStringAsFixed(1)} km')),
              ],
            ),
            const SizedBox(height: 14),
            Text(r.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Text(
              'Autor: ${r.authorEmail}',
              style: const TextStyle(color: Colors.black54),
            ),
            const Spacer(),
            if (!isMine)
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/chat',
                  arguments: {'title': r.title, 'email': r.authorEmail},
                ),
                icon: const Icon(Icons.chat_outlined),
                label: const Text('Entrar em contato'),
              )
            else
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Editar (em breve)'),
              ),
          ],
        ),
      ),
    );
  }
}
