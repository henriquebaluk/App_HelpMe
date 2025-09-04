import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/validators.dart';
import '../widgets/atoms/app_input.dart';
import '../widgets/atoms/app_button.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppInput(
                controller: _name,
                label: 'Nome',
                icon: Icons.person_outline,
                validator: (v) => minLen(3, v),
              ),
              const SizedBox(height: 12),
              AppInput(
                controller: _email,
                label: 'E-mail',
                icon: Icons.email_outlined,
                validator: emailValidator,
              ),
              const SizedBox(height: 12),
              AppInput(
                controller: _password,
                label: 'Senha',
                icon: Icons.lock_outline,
                validator: (v) => minLen(6, v),
                obscureText: true,
              ),
              const SizedBox(height: 18),
              AppButton(
                label: _busy ? 'Salvando...' : 'Cadastrar',
                icon: Icons.check_circle_outline,
                color: Colors.orange.shade700,
                onPressed: _busy
                    ? () {}
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        setState(() => _busy = true);
                        await context.read<AuthProvider>().signup(
                          _name.text.trim(),
                          _email.text.trim(),
                          _password.text,
                        );
                        setState(() => _busy = false);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cadastro realizado! Faça login.'),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
