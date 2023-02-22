import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

class Coin extends StatelessWidget {
  final String imagePath;
  final int money;
  const Coin({super.key, required this.imagePath, required this.money});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(13),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 17,
                width: 17,
                fit: BoxFit.cover,
              ),
              AnimatedFlipCounter(
                duration: const Duration(milliseconds: 4500),
                value: money,
                textStyle: const TextStyle(fontSize: 14, color: Colors.black),
                prefix: ' x ',
              )
            ],
          ),
        ));
  }
}
