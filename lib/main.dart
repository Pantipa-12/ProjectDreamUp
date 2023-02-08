import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyWidget());
}

// ignore: use_key_in_widget_constructors
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: "My app ",
      // ignore: prefer_const_constructors
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Center(
        // ignore: prefer_const_constructors
        child: Text(
          "Dream up",
          // ignore: prefer_const_constructors
          style: TextStyle(color: Color.fromARGB(255, 239, 248, 173)),
        ),
      )),
      // ignore: prefer_const_constructors
      body: Center(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text("Hello"),
            const Text("Bye"),
            const Text("Cat"),
          ],
        ),
      ),
    );
  }
}
