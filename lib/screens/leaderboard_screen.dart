import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = List.generate(10, (i) => {'name': 'Voluntário ${i+1}', 'score': (100 - i * 7)});
    return Scaffold(
      appBar: AppBar(title: const Text('Ranking de Voluntários')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) {
          final it = data[i];
          return ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            leading: CircleAvatar(child: Text('${i+1}')),
            title: Text(it['name'].toString(), style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text('Pontos: ${it['score']}'),
            trailing: const Icon(Icons.star, color: Colors.amber),
          );
        },
      ),
    );
  }
}
