import 'package:flutter/material.dart';
import 'package:pastry/src/screens/auth/signup.dart';
import 'dart:io';
import '../../../repositories/authentication_repository.dart';
import 'package:flutter/foundation.dart';

import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  final AuthenticationRepository authRepo;

  const LoginScreen({Key? key, required this.authRepo}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildEmailInput(),
            _buildPasswordInput(),
            _buildLoginButton(context),
            _buildSocialLogins(context),
            _buildResetPasswordButton(context),
            _buildSwitchToSignupButton(context),
          ],
        )),
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

  Widget _buildPasswordInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await widget.authRepo.signInWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
          );
          // Navigate to the chat page or another screen upon successful login
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      },
      child: Text('Login'),
    );
  }

  Widget _buildSocialLogins(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.login),
          onPressed: () async {
            try {
              await widget.authRepo.signInWithGoogle();
              // Navigate to the chat page or another screen upon successful login
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.facebook),
          onPressed: () async {
            try {
              await widget.authRepo.signInWithFacebook();
              // Navigate to the chat page or another screen upon successful login
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          },
        ),
        if (!kIsWeb && Platform.isIOS)
          IconButton(
            icon: Icon(Icons.apple),
            onPressed: () async {
              try {
                await widget.authRepo.signInWithApple();
                // Navigate to the chat page or another screen upon successful login
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
          ),
      ],
    );
  }

  // In login_screen.dart

  Widget _buildSwitchToSignupButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignupScreen(authRepo: widget.authRepo)),
        );
      },
      child: Text('Don\'t have an account? Sign up'),
    );
  }

  // In forgot_password_screen.dart

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
