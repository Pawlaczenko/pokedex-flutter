import 'package:flutter/material.dart';
import 'package:pokedex/screen/home_page.dart';
import 'package:pokedex/screen/pokemon_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromARGB(255, 255, 119, 119),
        )
      ),
      home: HomePage(),
      routes: {
        '/pokemonList': (context) => PokemonListPage(title: 'All Pokemon')
      }
    );
  }
}