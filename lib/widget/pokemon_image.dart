import 'package:flutter/material.dart';
import 'package:pokedex/main.dart';

class PokemonImage extends StatelessWidget {
  final String? url;
  final String defaultUrl = "https://www.toolworld.in/storage/media/product/noimage.png";

  const PokemonImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.65),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Image.network(
            (url != null) ? url as String : defaultUrl,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}