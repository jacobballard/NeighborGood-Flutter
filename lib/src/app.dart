import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:pastry/main.dart';
import 'package:pastry/repositories/authentication_repository.dart';
import 'package:pastry/src/screens/auth/login.dart';
import 'package:pastry/src/screens/tab_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null
              ? LoginScreen(
                  authRepo: AuthenticationRepository(),
                )
              : MyTabBar();
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
