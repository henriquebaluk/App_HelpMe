import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/validators.dart';
import '../widgets/atoms/app_input.dart';
import '../widgets/atoms/app_button.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Entrar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
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
                label: _busy ? 'Entrando...' : 'Entrar',
                icon: Icons.login,
                color: Colors.green.shade700,
                onPressed: _busy
                    ? () {}
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        setState(() => _busy = true);
                        final ok = await context.read<AuthProvider>().login(
                          _email.text.trim(),
                          _password.text,
                        );
                        setState(() => _busy = false);
                        if (ok) {
                          if (mounted) {
                            Navigator.pushReplacementNamed(context, '/home');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bem-vindo de volta!'),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: cs.error,
                              content: Text(
                                'Credenciais inválidas',
                                style: TextStyle(color: cs.onError),
                              ),
                            ),
                          );
                        }
                      },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/signup'),
                child: const Text('Não tem conta? Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
