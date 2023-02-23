import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_demo/pages/auth_page.dart';
import 'dart:async';

StreamController<double> streamController = StreamController<double>();
StreamController<int> streamControllerInt = StreamController<int>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.amber,
          fontFamily: GoogleFonts.marmelad().fontFamily),
      home: const AuthPage(),
    );
  }
}
