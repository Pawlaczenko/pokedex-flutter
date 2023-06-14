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

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final routeName = settings.name;

    if (routeName!.startsWith('/pokemon/')) {
      final pokemonId = routeName.substring('/pokemon/'.length);

      return MaterialPageRoute(
        builder: (context) => PokemonDetailPage(title: "Pokemon", pokemonId: pokemonId),
      );
    }

    return null;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 255, 119, 119),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          toolbarHeight: 50,
          iconTheme: IconThemeData(color: Colors.black),
        )
      ),
      home: const HomePage(),
      routes: {
        '/pokemonList': (context) => const PokemonListPage(title: 'All Pokemon'),
      },
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}