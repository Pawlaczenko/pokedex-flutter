import 'dart:core';

class PokemonData {
  final String name;
  final String url;

  PokemonData({required this.name, required this.url});

  factory PokemonData.fromJson(Map<String, dynamic> json) => PokemonData(
    name: json["name"],
    url: json["url"]
  );
}