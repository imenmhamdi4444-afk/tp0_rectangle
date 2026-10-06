import 'dart:math';
import 'package:flutter/material.dart';

final Random rng = Random();

Color randomColor() =>
    Color.fromARGB(255, rng.nextInt(256), rng.nextInt(256), rng.nextInt(256));

class RectNode {
  Color color1;
  Color color2; // used only in gradient mode
  Axis? direction; // null = leaf
  RectNode? first;
  RectNode? second;

  RectNode()
      : color1 = randomColor(),
        color2 = randomColor();

  bool get isLeaf => first == null;

  int get totalRectangles {
    if (isLeaf) return 1;
    return (first?.totalRectangles ?? 0) + (second?.totalRectangles ?? 0);
  }
}