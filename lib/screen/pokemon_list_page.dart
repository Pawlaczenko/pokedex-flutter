import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon.dart';
import 'package:http/http.dart' as http;

import '../widget/pokemon_window_widget.dart';

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

  @override
  void initState() {
    super.initState();
    pokemons = fetchPokemonList();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                      //TODO
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
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        childAspectRatio: 1 / 1.25,
                      ),
                      itemCount: snapshot.data?.length,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return GridTile(
                          child: PokemonWindowWidget(
                            pokemon: snapshot.data![index],
                          ),
                        );
                      },
                    );
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () => {loadPage(1)}, child: const Text("First")),
                  ElevatedButton.icon(onPressed: () => {loadPage(page-1)}, icon: const Icon(Icons.arrow_left_outlined) , label: const Text("Prev")),
                  Text(style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.w700),"$page"),
                  Directionality(textDirection:TextDirection.rtl, child: ElevatedButton.icon(onPressed: () => {loadPage(page+1)}, icon: const Icon(Icons.arrow_left_outlined) , label: const Text("Next"))),
                  ElevatedButton(onPressed: () => {loadPage(pageCount)}, child: const Text("Last")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}