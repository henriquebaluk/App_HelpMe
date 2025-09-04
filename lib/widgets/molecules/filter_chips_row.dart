import 'package:flutter/material.dart';

class FilterChipsRow extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;
  const FilterChipsRow({super.key, required this.options, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((o) {
          final sel = o == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(o),
              selected: sel,
              onSelected: (_) => onChanged(o),
            ),
          );
        }).toList(),
      ),
    );
  }
}
