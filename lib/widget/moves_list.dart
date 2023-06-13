import 'package:flutter/material.dart';

class PokemonMovesList extends StatelessWidget {
  final List<String> moves;
  final String heading;

  const PokemonMovesList({Key? key, required this.moves, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayMoves = moves.take(6).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            heading,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: displayMoves.length,
          itemBuilder: (context, index) {
            final move = displayMoves[index];
            return Card(
              margin: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 4),
              child: ListTile(
                title: Text(move),
              ),
            );
          },
        ),
      ],
    );
  }
}
