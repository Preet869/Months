import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:month_project/Auth/login_or_register.dart';
import 'package:month_project/Pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              //User is logged in
              if (snapshot.hasData) {
                return const HomePage();
              }
              //User is not logged in
              else {
                return const LoginOrRegister();
              }
            }));
  }
}
