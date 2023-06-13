import 'dart:ui';

import 'package:flutter/material.dart';

Color getTypeColor(String? type) {
  Map<String, Color?> typeColors = {
    'normal': const Color.fromARGB(255, 187, 187, 187),
    'fire': const Color.fromARGB(255, 255, 119, 119),
    'water': const Color.fromARGB(255, 119, 166, 255),
    'electric': const Color.fromARGB(255, 255, 239, 119),
    'grass': const Color.fromARGB(255, 119, 204, 119),
    'ice': const Color.fromARGB(255, 187, 239, 239),
    'fighting': const Color.fromARGB(255, 255, 170, 119),
    'poison': const Color.fromARGB(255, 187, 119, 204),
    'ground': const Color.fromARGB(255, 187, 153, 85),
    'flying': const Color.fromARGB(255, 170, 153, 255),
    'psychic': const Color.fromARGB(255, 255, 119, 187),
    'bug': const Color.fromARGB(255, 170, 204, 85),
    'rock': const Color.fromARGB(255, 204, 170, 119),
    'ghost': const Color.fromARGB(255, 170, 119, 255),
    'dragon': const Color.fromARGB(255, 85, 51, 153),
    'dark': const Color.fromARGB(255, 85, 85, 85),
    'steel': const Color.fromARGB(255, 136, 153, 170),
    'fairy': const Color.fromARGB(255, 255, 204, 255),
  };

  return typeColors[type]?.withOpacity(0.25) ?? const Color.fromARGB(255, 255, 255, 255);
}