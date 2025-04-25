import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/presentation/home_page.dart';
import '../application/login_controller.dart';
import '../domain/auth_validator.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => AuthValidator.validateEmail(value ?? ''),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) => AuthValidator.validatePassword(value ?? ''),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: loginState.isLoading
                    ? null
                    : () async {
                  if (_formKey.currentState!.validate()) {
                    await ref.read(loginProvider.notifier).login(
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                      );
                    }
                  }
                },
                child: loginState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}