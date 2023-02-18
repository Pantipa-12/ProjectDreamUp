import 'package:flutter/material.dart';

class Coin extends StatelessWidget {
  final String imagePath;
  const Coin({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.grey[400],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Image.asset(imagePath, height: 15, width: 15),
            Text(" x 123", style: TextStyle(color: Colors.black, fontSize: 10))
          ],
        ));
  }
}
