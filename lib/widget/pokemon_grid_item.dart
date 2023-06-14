import 'package:flutter/material.dart';
import 'package:pokedex/widget/pokemon_id.dart';
import 'package:pokedex/widget/pokemon_image.dart';
import 'package:pokedex/widget/pokemon_name.dart';

import '../helpers/getTypeColor.dart';
import '../model/pokemon.dart';

class PokemonGridItem extends StatelessWidget {
  final Pokemon pokemon;
  final bool isColumn;
  const PokemonGridItem({super.key, required this.pokemon, required this.isColumn});

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/pokemon/${pokemon.id}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: getTypeColor(pokemon.types[0]),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: .5,
              blurRadius: 15,
              offset: const Offset(0, 1),
            ),
          ]
        ),
        padding: const EdgeInsets.all(10),
        child: isColumn
        ? Column(
            children: [
              PokemonImage(url: pokemon.sprite),
              const SizedBox(height: 10),
              PokemonName(pokemonName: pokemon.name),
              PokemonId(id: pokemon.id),
            ],
          )
        : Row(
            children: [
              PokemonImage(url: pokemon.sprite),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PokemonName(pokemonName: pokemon.name),
                    PokemonId(id: pokemon.id),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}