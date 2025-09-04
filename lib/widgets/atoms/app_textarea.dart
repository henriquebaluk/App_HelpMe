import 'package:flutter/material.dart';

class AppTextarea extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final int minLines;
  final int maxLines;

  const AppTextarea({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.minLines = 3,
    this.maxLines = 4,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.multiline,
      minLines: minLines,
      maxLines: maxLines,
      decoration: const InputDecoration(
        alignLabelWithHint: true,
      ).copyWith(labelText: label),
    );
  }
}
