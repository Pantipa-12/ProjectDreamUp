import 'package:flutter/material.dart';

class MoveCoin extends StatefulWidget {
  const MoveCoin({super.key});

  @override
  State<MoveCoin> createState() => _MoveCoinState();
}

int coinX = 0;
int coinY = 0;

class _MoveCoinState extends State<MoveCoin> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Image.asset("lib/images.coin.dart"));
  }
}
