import 'package:flutter/material.dart';
import 'package:pokedex/widget/pokemon_grid_item.dart';

import '../model/pokemon.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> items;

  const PokemonList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          margin: EdgeInsets.only(bottom: 10),
          child: PokemonGridItem(
            pokemon: items[index],
            isColumn: false,
          ),
        );
      },
    );
  }
}