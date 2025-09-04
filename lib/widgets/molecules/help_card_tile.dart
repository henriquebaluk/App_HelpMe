import 'package:flutter/material.dart';
import '../../core/app_theme.dart' show categoryColor;

class HelpCardTile extends StatelessWidget {
  final String title;
  final String description;
  final String category; // Serviço, Doação, Transporte, Companhia
  final String urgency; // Alta, Média, Baixa
  final double distanceKm;
  final VoidCallback onTap;

  /// Mostra o selo "Meu" quando o pedido é do usuário logado
  final bool mine;

  const HelpCardTile({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.urgency,
    required this.distanceKm,
    required this.onTap,
    this.mine = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = categoryColor(category);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.03),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Faixa colorida à esquerda (substitui o Border não-uniforme)
              Container(
                width: 6,
                height: 72,
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Ícone dentro de um bloco suave
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [c.withOpacity(.18), c.withOpacity(.06)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.front_hand, color: c),
              ),
              const SizedBox(width: 12),

              // Conteúdo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (mine)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.blueGrey.shade200,
                              ),
                            ),
                            child: const Text(
                              'Meu',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        Chip(
                          label: Text(category),
                          backgroundColor: c.withOpacity(.12),
                          side: BorderSide(color: c.withOpacity(.25)),
                          labelStyle: TextStyle(
                            color: c,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Chip(label: Text('Urgência: $urgency')),
                        Chip(
                          label: Text('${distanceKm.toStringAsFixed(1)} km'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
