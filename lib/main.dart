import 'package:flutter/material.dart';
import 'package:pokedex/screen/home_page.dart';
import 'package:pokedex/screen/pokemon_detail_page.dart';
import 'package:pokedex/screen/pokemon_list_page.dart';

void main() {
  runApp(const MyApp());
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Route generator function
  Route<dynamic>? generateRoute(RouteSettings settings) {
    // Extract the route name
    final routeName = settings.name;

    // Handle different routes
    if (routeName!.startsWith('/pokemon/')) {
      // Extract the pokemonId from the route
      final pokemonId = routeName.substring('/pokemon/'.length);

      return MaterialPageRoute(
        builder: (context) => PokemonDetailPage(title: "Pokemon", pokemonId: pokemonId),
      );
    }

    // If no match is found, return null
    return null;
  }

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
        '/pokemonList': (context) => const PokemonListPage(title: 'All Pokemon'),
      },
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}