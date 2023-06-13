import 'package:flutter/material.dart';

class PokemonId extends StatelessWidget {
  final int id;

  const PokemonId({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "#${id.toString().padLeft(3, '0')}",
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color.fromARGB(255, 59, 61, 98),
        fontSize: 16, 
        fontWeight: FontWeight.normal,
      )
    );
  }
}