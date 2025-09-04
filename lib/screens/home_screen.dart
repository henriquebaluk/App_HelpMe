import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/map_screen.dart';
import '../screens/my_requests_screen.dart';
import '../screens/profile_screen.dart';

import '../providers/requests_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/notifications_provider.dart';

import '../widgets/molecules/help_card_tile.dart';
import '../models/request_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  String _category = 'Todos';
  String _sort = 'Proximidade';
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final tabs = <Widget>[
      _FeedTab(category: _category, sort: _sort, query: _query),
      const MapScreen(),
      const MyRequestsScreen(),
      const ProfileScreen(),
    ];

    final unread = context.watch<NotificationsProvider>().unreadCount;

    return Scaffold(
      appBar: AppBar(
        // LOGO + nome bem visíveis no topo roxo
        title: Row(
          children: const [
            Icon(Icons.front_hand, size: 22), // “mãos”
            SizedBox(width: 8),
            Text('HelpMe'),
          ],
        ),
        actions: [
          // NOTIFICAÇÕES (com badge)
          IconButton(
            tooltip: 'Notificações',
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_outlined),
                if (unread > 0)
                  Positioned(
                    right: -1,
                    top: -1,
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 10,
                        minHeight: 10,
                      ),
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Criar pedido',
            onPressed: () => Navigator.pushNamed(context, '/create'),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_index == 0) _Header(onSearch: (q) => setState(() => _query = q)),
          if (_index == 0)
            _Filters(
              category: _category,
              sort: _sort,
              onChanged: (c, s) => setState(() {
                _category = c;
                _sort = s;
              }),
            ),
          Expanded(child: tabs[_index]),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list),
            label: 'Lista',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Mapa',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Meus',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
      floatingActionButton: _index == 0
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.pushNamed(context, '/create'),
              icon: const Icon(Icons.add),
              label: const Text('Novo pedido'),
            )
          : null,
    );
  }
}

/// Header da lista – AGORA com **cor única suave** (lavanda),
/// combinando com o topo roxo, sem gradiente.
class _Header extends StatelessWidget {
  final ValueChanged<String> onSearch;
  const _Header({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF1E8FF), // lavanda suave
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pedidos próximos',
            style: TextStyle(
              color: Color(0xFF402781), // roxo escuro para contraste
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            onChanged: onSearch,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              hintText: 'Buscar por título ou descrição...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedTab extends StatelessWidget {
  final String category;
  final String sort;
  final String query;

  const _FeedTab({
    required this.category,
    required this.sort,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RequestsProvider>();
    final me = context.read<AuthProvider>().currentUser?.email;

    // Cópia mutável para ordenar/filtrar
    List<RequestModel> items = List<RequestModel>.from(provider.items);

    // Busca
    if (query.trim().isNotEmpty) {
      final q = query.toLowerCase();
      items = items
          .where(
            (e) =>
                e.title.toLowerCase().contains(q) ||
                e.description.toLowerCase().contains(q),
          )
          .toList();
    }

    // Categoria
    if (category != 'Todos') {
      items = items.where((e) => e.category == category).toList();
    }

    // Ordenação
    if (sort == 'Proximidade') {
      items.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    } else {
      const ord = {'Alta': 0, 'Média': 1, 'Baixa': 2};
      items.sort(
        (a, b) => (ord[a.urgency] ?? 9).compareTo(ord[b.urgency] ?? 9),
      );
    }

    if (items.isEmpty) {
      return const Center(child: Text('Sem pedidos por aqui.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final e = items[i];
        final mine = (me != null && me == e.authorEmail);
        return HelpCardTile(
          title: e.title,
          description: e.description,
          category: e.category,
          urgency: e.urgency,
          distanceKm: e.distanceKm,
          mine: mine,
          onTap: () => Navigator.pushNamed(context, '/details', arguments: e),
        );
      },
    );
  }
}

class _Filters extends StatelessWidget {
  final String category;
  final String sort;
  final void Function(String, String) onChanged;

  const _Filters({
    required this.category,
    required this.sort,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(labelText: 'Categoria'),
              items: const [
                'Todos',
                'Serviço',
                'Doação',
                'Transporte',
                'Companhia',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => onChanged(v ?? category, sort),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: sort,
              decoration: const InputDecoration(labelText: 'Ordenar por'),
              items: const [
                'Proximidade',
                'Urgência',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => onChanged(category, v ?? sort),
            ),
          ),
        ],
      ),
    );
  }
}
