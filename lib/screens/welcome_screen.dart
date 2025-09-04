
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          // Fundo verde com detalhes
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primary, cs.primaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: -40, left: -40,
            child: _bubble(120, Colors.white.withOpacity(.08)),
          ),
          Positioned(
            bottom: -50, right: -30,
            child: _bubble(160, Colors.white.withOpacity(.12)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.front_hand, size: 72, color: Colors.white),
                  ),
                  const SizedBox(height: 18),
                  const Text('HelpMe', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text('Ajuda comunitária, rápida e perto de você', style: TextStyle(color: Colors.white.withOpacity(.9))),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 280,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      icon: const Icon(Icons.login),
                      label: const Text('Entrar'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: cs.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 280,
                    child: FilledButton.tonalIcon(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      icon: const Icon(Icons.person_add_alt_1),
                      label: const Text('Criar conta'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(double size, Color color) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: color, shape: BoxShape.circle,
      ),
    );
  }
}
