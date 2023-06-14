import 'package:flutter/material.dart';
import 'package:pokedex/main.dart';

class PokemonImage extends StatefulWidget {
  final String? url;

  const PokemonImage({Key? key, required this.url}) : super(key: key);

  @override
  State<PokemonImage> createState() => PokemonImageState();
}

class PokemonImageState extends State<PokemonImage> {
  double turns = 0.0;
  final String defaultUrl = "https://www.toolworld.in/storage/media/product/noimage.png";

  void _changeRotation() {
    setState(() => turns += 1.0);
  }

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
          AnimatedRotation(
            turns: turns,
            duration: const Duration(seconds: 1),
            child: InkWell(
              onTap: () {
                _changeRotation();
              },
              child: Image.network(
                (widget.url != null) ? widget.url as String : defaultUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}