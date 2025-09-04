import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/validators.dart';
import '../widgets/atoms/app_input.dart';
import '../widgets/atoms/app_button.dart';
import '../widgets/atoms/app_textarea.dart';

import '../models/request_model.dart';
import '../providers/requests_provider.dart';
import '../providers/auth_provider.dart';

// Notificações
import '../providers/notifications_provider.dart';
import '../models/notification_model.dart';

class CreateHelpScreen extends StatefulWidget {
  const CreateHelpScreen({super.key});

  @override
  State<CreateHelpScreen> createState() => _CreateHelpScreenState();
}

class _CreateHelpScreenState extends State<CreateHelpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();
  String _category = 'Serviço';
  String _urgency = 'Média';

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final email = auth.currentUser?.email ?? 'anon@helpme.app';

    // Coords base (SP) + variação pequena
    const baseLat = -23.5558;
    const baseLng = -46.6396;
    final r = Random();

    final req = RequestModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _title.text.trim(),
      description: _desc.text.trim(),
      category: _category,
      urgency: _urgency,
      distanceKm: 0.4 + r.nextDouble() * 3,
      lat: baseLat + (r.nextDouble() - .5) * 0.03,
      lng: baseLng + (r.nextDouble() - .5) * 0.03,
      authorEmail: email,
    );

    // Adiciona na store local
    context.read<RequestsProvider>().add(req);

    // Cria uma notificação "Pedido publicado"
    context.read<NotificationsProvider>().add(
      AppNotification(
        id: req.id,
        title: 'Pedido publicado',
        body: 'Seu pedido "${req.title}" foi publicado.',
        date: DateTime.now(),
      ),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Pedido publicado!')));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AppInput(
                controller: _title,
                label: 'Título',
                icon: Icons.title,
                validator: requiredField,
              ),
              const SizedBox(height: 12),
              AppTextarea(
                controller: _desc,
                label: 'Descrição',
                validator: (v) => minLen(10, v),
                maxLines: 4,
              ),
              const SizedBox(height: 12),

              // Categoria
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: const ['Serviço', 'Doação', 'Transporte', 'Companhia']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v ?? _category),
              ),
              const SizedBox(height: 12),

              // Urgência
              DropdownButtonFormField<String>(
                value: _urgency,
                decoration: InputDecoration(
                  labelText: 'Urgência',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: const ['Alta', 'Média', 'Baixa']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _urgency = v ?? _urgency),
              ),
              const SizedBox(height: 18),

              AppButton(
                label: 'Publicar pedido',
                icon: Icons.send,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
