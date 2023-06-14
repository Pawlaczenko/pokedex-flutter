import 'package:flutter/material.dart';

import '../helpers/getTypeColor.dart';

class PokemonTypesGrid extends StatelessWidget {
  final List<String> types;

  const PokemonTypesGrid({Key? key, required this.types}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: types.map((type) {
        return Chip(
          label: Text(type),
          backgroundColor: getTypeColor(type),
        );
      }).toList(),
    );
  }
}