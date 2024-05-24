import 'package:flutter/material.dart';

class ColorHelper {
  ColorHelper();

  final List<MaterialColor> swatches = [
    Colors.grey,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.pink,
  ];

  MaterialColor getColor(int index) {
    if (index < 0 || index > swatches.length) {
      throw RangeError("Invalid index");
    }

    return swatches[index];
  }

  List<MaterialColor> getAllColors() {
    return swatches;
  }
}
