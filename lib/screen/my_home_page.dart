import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon.dart';
import 'package:http/http.dart' as http;

import '../widget/pokemon_window_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Pokemon>> pokemons;
  
  Future<Pokemon> fetchPokemon(String url) async {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  Future<List<Pokemon>> fetchPokemonList() async {
    String url = "https://pokeapi.co/api/v2/pokemon";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final pokemonList = data['results'].cast<Map<String, dynamic>>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Pokemon>>(
                future: fetchPokemonList(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.5/1
                      ),
                      // scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return GridTile( child: PokemonWindowWidget(pokemon: snapshot.data![index]));
                      }
                    );
                  }
                  if(snapshot.hasError) {
                    return const Text("Error");
                  }
            
                  return const CircularProgressIndicator();
                }
              ),
            )
          ],
        ),
      )
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     child: ListView.builder(
    //       itemCount: pokemonList.length,
    //       itemBuilder: (context, index) {
    //       return InkWell( child: PokemonWindowWidget(pokemon: pokemonList[index]));
    //     },),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}