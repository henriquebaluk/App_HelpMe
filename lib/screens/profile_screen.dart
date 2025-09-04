
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/requests_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;
    final myCount = user == null ? 0 : context.watch<RequestsProvider>().byAuthor(user.email).length;

    if(user == null){
      return const Center(child: Text('Você não está logado.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: const Icon(Icons.person, size: 36),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  Text(user.email, style: const TextStyle(color: Colors.black54)),
                ],
              )
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _StatCard(label: 'Meus pedidos', value: myCount.toString()),
              const SizedBox(width: 12),
              const _StatCard(label: 'Ajudas feitas', value: '3'),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if(context.mounted){
                Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text('Sair'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
          )
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0,4))],
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
