import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Bar extends StatelessWidget {
  final double percent;
  const Bar({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
          tween: Tween<double>(begin: 0, end: percent),
          builder: (context, value, child) => LinearProgressIndicator(
            value: value,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade400),
            backgroundColor: Colors.blue.shade100,
          ),
        ),
      ),
    );
  }
}
