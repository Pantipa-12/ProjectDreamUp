import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_demo/main.dart';
import 'package:store_demo/pages/first_page.dart';
import 'package:store_demo/pages/sign_in.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FirstPage(
              stream: streamController.stream, 
              streamRemoveList: streamControllerInt.stream,);
          } else {
            return SignInPage();
          }
        },
      ),
    );
  }
}
