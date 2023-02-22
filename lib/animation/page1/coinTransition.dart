import 'package:flutter/material.dart';

Widget coinTransiton(
    {required Widget widget,
    required AnimationController animationController}) {
  return FadeTransition(
    opacity: Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastLinearToSlowEaseIn)),
    child: SlideTransition(
      position: Tween<Offset>(
              begin: const Offset(0.0, 0.0), end: const Offset(0.0, -0.5))
          .animate(CurvedAnimation(
              parent: animationController,
              curve: Curves.fastLinearToSlowEaseIn)),
      child: widget,
    ),
  );
}
