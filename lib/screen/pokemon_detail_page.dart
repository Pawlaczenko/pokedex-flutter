import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/main.dart';

import '../helpers/getTypeColor.dart';
import '../model/pokemon.dart';
import '../model/pokemonDetails.dart';
import '../widget/moves_list.dart';
import '../widget/pokemon_id.dart';
import '../widget/pokemon_image.dart';
import '../widget/pokemon_name.dart';
import '../widget/types_list.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key, required this.title, required this.pokemonId});

  final String title;
  final String pokemonId;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late Future<PokemonDetails> pokemon;
  bool isLoading = false;
  
  Future<PokemonDetails> fetchPokemon() async {
    isLoading = true;
    final url = "https://pokeapi.co/api/v2/pokemon/${widget.pokemonId}";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      isLoading = false;
      return PokemonDetails.fromJson(jsonDecode(response.body));
    } else {
      isLoading = false;
      throw Exception('Failed to load pokemon');
    }
  }

    @override
  void initState() {
    super.initState();
    pokemon = fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.pokemonId} - ${widget.title}"),
      ),
      body: FutureBuilder<PokemonDetails>(
        future: pokemon,
        builder: (context, snapshot) {
          if (snapshot.hasData && !isLoading) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  PokemonName(pokemonName: snapshot.data!.name, fontSize: 36),
                  PokemonId(id: snapshot.data!.id),
                  Container(
                    decoration: BoxDecoration(
                      color: getTypeColor(snapshot.data?.types[0]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: PokemonImage(url: snapshot.data!.sprite),
                  ),
                  const SizedBox(height: 10),
                  PokemonTypesGrid(types: snapshot.data!.types),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Weight')),
                      DataColumn(label: Text('Height')),
                      DataColumn(label: Text('Experience')),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(Text(snapshot.data!.weight.toString())),
                          DataCell(Text(snapshot.data!.height.toString())),
                          DataCell(Text(snapshot.data!.exp.toString())),
                        ],
                      ),
                    ],
                  ),
                  PokemonMovesList(moves: snapshot.data!.moves, heading: 'Moves'),
                  const SizedBox(height: 10),
                ],
              ),
            ); // Return the Text widget
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}