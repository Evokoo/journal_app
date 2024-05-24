import 'package:flutter/material.dart';

final List<MaterialColor> cardColours = [
  Colors.yellow,
  Colors.blue,
  Colors.green,
  Colors.pink,
];

MaterialColor getColor(int index) {
  return cardColours[index];
}

List<MaterialColor> getAllColors() {
  return cardColours;
}
