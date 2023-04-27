import 'package:flutter/material.dart';

import '../model/pokemon.dart';

Map<String, Color?> typeColors = {
  'normal': Color.fromARGB(255, 187, 187, 187),
  'fire': Color.fromARGB(255, 255, 119, 119),
  'water': Color.fromARGB(255, 119, 166, 255),
  'electric': Color.fromARGB(255, 255, 239, 119),
  'grass': Color.fromARGB(255, 119, 204, 119),
  'ice': Color.fromARGB(255, 187, 239, 239),
  'fighting': Color.fromARGB(255, 255, 170, 119),
  'poison': Color.fromARGB(255, 187, 119, 204),
  'ground': Color.fromARGB(255, 187, 153, 85),
  'flying': Color.fromARGB(255, 170, 153, 255),
  'psychic': Color.fromARGB(255, 255, 119, 187),
  'bug': Color.fromARGB(255, 170, 204, 85),
  'rock': Color.fromARGB(255, 204, 170, 119),
  'ghost': Color.fromARGB(255, 170, 119, 255),
  'dragon': Color.fromARGB(255, 85, 51, 153),
  'dark': Color.fromARGB(255, 85, 85, 85),
  'steel': Color.fromARGB(255, 136, 153, 170),
  'fairy': Color.fromARGB(255, 255, 204, 255),
};

class PokemonWindowWidget extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonWindowWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: typeColors[pokemon.types[0]],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ]
      ),
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 10,
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Image.network(
            pokemon.sprite,
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                pokemon.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16, 
                  fontWeight: FontWeight.bold
                )
              )
            )
          )
        ],
      )
    );
  }
}