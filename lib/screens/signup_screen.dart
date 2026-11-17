import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  void _signup() {
    // TODO: Backend integration — call your register API here
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Account',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Join LearnEra and start learning today.',
              style: TextStyle(color: AppColors.textGrey, fontSize: 14),
            ),
            const SizedBox(height: 32),
            const Text('Full Name',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                hintText: 'John Doe',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Email',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'you@example.com',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Password',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'At least 8 characters',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: _signup, child: const Text('Sign Up')),
          ],
        ),
      ),
    );
  }
}