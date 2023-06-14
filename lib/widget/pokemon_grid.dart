import 'package:flutter/material.dart';
import 'package:pokedex/widget/pokemon_grid_item.dart';

import '../model/pokemon.dart';

class PokemonGrid extends StatelessWidget {
  final List<Pokemon> items;

  const PokemonGrid({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 1 / 1.1,
      ),
      itemCount: items.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return GridTile(
          child: PokemonGridItem(
            pokemon: items[index],
            isColumn: true,
          ),
        );
      },
    );
  }
}