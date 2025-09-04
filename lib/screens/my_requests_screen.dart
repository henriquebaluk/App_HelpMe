import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/requests_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/molecules/help_card_tile.dart';
import '../models/request_model.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final email = auth.currentUser?.email;

    final List<RequestModel> items = email == null
        ? <RequestModel>[]
        : context.watch<RequestsProvider>().byAuthor(email);

    if (email == null) {
      return const Center(
        child: Text('Entre na sua conta para ver seus pedidos.'),
      );
    }

    if (items.isEmpty) {
      return const Center(child: Text('Você ainda não criou pedidos.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final e = items[i];
        return HelpCardTile(
          title: e.title,
          description: e.description,
          category: e.category,
          urgency: e.urgency,
          distanceKm: e.distanceKm,
          mine: true, // sempre "meu" nesta lista
          onTap: () => Navigator.pushNamed(context, '/details', arguments: e),
        );
      },
    );
  }
}
