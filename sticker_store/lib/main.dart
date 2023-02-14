import 'package:flutter/material.dart';
import 'package:sticker_store/sticker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dream Up',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Store'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //accept object
  List<Sticker> choices = [
    Sticker("Killer Whale", "3"),
    Sticker("Baby Duck", "3"),
    Sticker("Doggie", "3"),
    Sticker("Kitty", "3")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sticker"),
        ),
        body: ListView.builder(
          itemCount: choices.length,
          itemBuilder: (BuildContext context, int index) {
            Sticker sticker = choices[index];
            return ListTile(
              title: Text(sticker.name),
              subtitle: Text("Price ${sticker.price} coins"),
            );
          },
        ));
  }
}
