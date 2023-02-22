import 'package:flutter/material.dart';

Widget moveCoin(
    {required double opacity,
    required Widget widget,
    required bool sizeBool,
    required bool moveBool,
    required Duration duration,
    required double alignmentX,
    required double alignmentY}) {
  return AnimatedAlign(
    alignment:
        moveBool ? Alignment(alignmentX, alignmentY) : Alignment.topRight,
    duration: duration,
    curve: Curves.fastOutSlowIn,
    child: AnimatedOpacity(
        opacity: opacity,
        duration: duration,
        child: AnimatedContainer(
            duration: duration,
            width: sizeBool ? 60 : 30,
            height: sizeBool ? 60 : 30,
            alignment: sizeBool ? Alignment.center : Alignment.topCenter,
            curve: Curves.fastOutSlowIn,
            child: widget)),
  );
}
