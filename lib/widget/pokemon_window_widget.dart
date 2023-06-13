import 'package:flutter/material.dart';

import '../model/pokemon.dart';

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
              width: 75.0,
              height: 75.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Image.network(
            (pokemon.sprite != null) ? pokemon.sprite as String : "https://www.toolworld.in/storage/media/product/noimage.png",
            fit: BoxFit.contain,
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