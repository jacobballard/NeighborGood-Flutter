import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:pastry/firebase_options.dart';
import 'package:pastry/src/app/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(App(authenticationRepository: authenticationRepository));
}
