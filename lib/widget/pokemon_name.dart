import 'package:flutter/material.dart';
import 'package:pokedex/main.dart';

class PokemonName extends StatelessWidget {
  final String pokemonName;
  final int? fontSize;

  const PokemonName({Key? key, required this.pokemonName, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      pokemonName.capitalize(),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: const Color.fromARGB(255, 39, 39, 39),
        fontSize: fontSize?.toDouble() ?? 16.0,
        fontWeight: FontWeight.bold,
      )
    );
  }
}