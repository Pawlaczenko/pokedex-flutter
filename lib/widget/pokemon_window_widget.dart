import 'package:flutter/material.dart';

import '../model/pokemon.dart';

class PokemonWindowWidget extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonWindowWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  pokemon.name,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16, 
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 100,
              height: 100,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Image.network(pokemon.sprite),
              )
            )
          )

        ],
      ),
    );
  }
}