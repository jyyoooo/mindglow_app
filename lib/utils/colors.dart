import 'dart:math';
import 'package:flutter/material.dart';

class Appcolor {
  static const Color blue = Color(0xFFB3E5FC);
  static const Color white = Colors.white;
  static const Color grey = Color.fromARGB(255, 0, 0, 0);
  static const Color red = Color.fromARGB(255, 242, 0, 0);
  static const Color peach = Color(0xFFFFC1A6);
  static const Color ashGrey = Color.fromARGB(255, 65, 35, 116);
  static const Color tranquilTeal = Color(0xFF5E8C8C);
  static const Color softBlue = Color(0xFFA0D6FF);
  static const Color gentleGreen = Color(0xFFB9E5A8);
  static const Color lightCream = Color(0xFFF9F8F6);
  static const Color deepCharcoal = Color(0xFF4F4F4F);
  static const Color rose = Color(0xFFFFC1E3);
  static const Color cardioColor = Colors.blueAccent;

}

Color generateRandomColor() {
  Random random = Random();
  int alpha = random.nextInt(256);
  int red = random.nextInt(256);
  int green = random.nextInt(256);
  int blue = random.nextInt(256);

  return Color.fromARGB(alpha, red, green, blue);
}
