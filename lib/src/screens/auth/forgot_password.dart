// In forgot_password_screen.dart

import 'package:flutter/material.dart';

import '../../../repositories/authentication_repository.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final AuthenticationRepository authRepo;

  ForgotPasswordScreen({required this.authRepo});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEmailInput(),
            _buildResetPasswordButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await widget.authRepo.resetPassword(_emailController.text);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password reset email sent')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      },
      child: Text('Reset Password'),
    );
  }
}
