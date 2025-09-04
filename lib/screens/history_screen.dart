import 'package:flutter/material.dart';
import '../core/local_store.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _store = LocalStore();
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await _store.getHistory();
    setState(() => _items = list.reversed.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico')),
      body: _items.isEmpty
        ? const Center(child: Text('Sem itens no histórico ainda.'))
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final it = _items[i];
              final rating = (it['rating'] ?? 0) as int;
              return ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                title: Text(it['title']?.toString() ?? 'Ajuda'),
                subtitle: Text((it['role']?.toString() ?? '') + (it['comment']!=null && it['comment']!='' ? ' — ${it['comment']}' : '')),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (ix) => Icon(ix < rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 20)),
                ),
              );
            },
          ),
    );
  }
}
