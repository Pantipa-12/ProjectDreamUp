import 'dart:async';

import 'package:compro/pages/first_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

StreamController<double> streamController = StreamController<double>();
StreamController<int> streamControllerInt =
    StreamController<int>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.amber,
          fontFamily: GoogleFonts.marmelad().fontFamily),
      home: FirstPage(
        stream: streamController.stream,
        streamRemoveList: streamControllerInt.stream,
      ),
    );
  }
}
