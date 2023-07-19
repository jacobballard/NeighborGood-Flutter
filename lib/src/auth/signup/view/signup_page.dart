import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/signup_cubit.dart';
import 'view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
      child: const SignUpPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            const BackButton(), // this will add a back button at the top of the page
        elevation: 0, // this removes the shadow below the AppBar
        backgroundColor: Colors
            .transparent, // this makes the AppBar background color transparent
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sign Up', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const SignUpForm(),
          ],
        ),
      ),
    );
  }
}
