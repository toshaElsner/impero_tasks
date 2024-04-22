import 'package:flutter/material.dart';

class ColorCategories {
  String? catName;
  List<Map<Color, int>>? colors;
  int? selectedColorIndex;


  ColorCategories(
      this.catName, this.colors, this.selectedColorIndex);
}
