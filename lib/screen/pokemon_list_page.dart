import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon.dart';
import 'package:http/http.dart' as http;

import '../widget/pokemon_grid.dart';
import '../widget/pokemon_list.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key, required this.title});
  final String title;

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late Future<List<Pokemon>> pokemons;
  int page = 1;
  int pageSize = 20;
  bool isLoading = false;
  String query = "";
  late int pageCount;
  bool isGrid = true;
  final myController = TextEditingController();
  
  Future<Pokemon> fetchPokemon(String url) async {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  Future<List<Pokemon>> fetchPokemonList() async {
    final offset = (page - 1) * pageSize;
    final url = "https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$pageSize";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final pokemonList = data['results'].cast<Map<String, dynamic>>();
      final totalResults = data['count'];
      pageCount = (totalResults ~/ pageSize) + (totalResults % pageSize > 0 ? 1 : 0);

      final result = await Future.wait(
        pokemonList.map<Future<Pokemon>>(
          (pokemon) => fetchPokemon(pokemon['url'])
        )
      );
      return result.toList().cast<Pokemon>();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  void loadPage(int incomingPage) {
    if (isLoading) {
      return;
    }
    setState(() {
      if (incomingPage > 0 && incomingPage <= pageCount) {
        isLoading = true;
        page = incomingPage;
        pokemons = fetchPokemonList().whenComplete(() {
          isLoading = false; // Update isLoading to false when the operation is completed
        });
      }
    });
  }

  void toggleView() {
    setState(() {
      isGrid = !isGrid;
    });
  }

  @override
  void initState() {
    super.initState();
    pokemons = fetchPokemonList();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
            onPressed: (){toggleView();}, 
            child: Icon(isGrid ? Icons.list : Icons.grid_view),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row( 
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: myController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search for Pokemon',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pokemon/${myController.text.trim().toLowerCase()}');
                    },
                    child: const Text('GO'),
                  ),
                  
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Pokemon>>(
                future: fetchPokemonList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && !isLoading) {
                    if(isGrid) {
                      return PokemonGrid(items: snapshot.data!);
                    } else {
                      return PokemonList(items: snapshot.data!);
                    }
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15,top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () => {loadPage(1)}, child: const Icon(Icons.first_page)),
                  ElevatedButton(onPressed: () => {loadPage(page-1)}, child: const Icon(Icons.keyboard_arrow_left)),
                  Text(style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.w700),"$page"),
                  ElevatedButton(onPressed: () => {loadPage(page+1)}, child: const Icon(Icons.keyboard_arrow_right)),
                  ElevatedButton(onPressed: () => {loadPage(pageCount)}, child: const Icon(Icons.last_page)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}