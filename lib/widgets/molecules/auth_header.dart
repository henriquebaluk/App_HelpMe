import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: cs.primary)),
        const SizedBox(height: 8),
        Text(subtitle, style: TextStyle(color: cs.onSurfaceVariant)),
        const SizedBox(height: 20),
      ],
    );
  }
}
