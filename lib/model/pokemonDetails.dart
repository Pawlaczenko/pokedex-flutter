import 'dart:core';

class PokemonDetails {
  final String name;
  final int id;
  final String? sprite;
  final List<String> types;
  final int? weight;
  final int? height;
  final int? exp;
  final List<String> moves;


  PokemonDetails(
    {
      required this.name, 
      required this.id, 
      this.sprite, 
      required this.types,
      this.weight,
      this.height,
      this.exp,
      required this.moves
    }
  );

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
  final List<dynamic> typesJson = json['types'] ?? [];
  final List<String> typeNames = typesJson
    .map((typeJson) => typeJson['type']['name'] as String)
    .toList();

  final List<dynamic> movesJson = json['moves'] ?? [];
  final List<String> moveNames = movesJson
    .map((moveJson) => moveJson['move']['name'] as String)
    .toList();

  return PokemonDetails(
    name: json['name'] as String,
    id: json['id'] as int,
    sprite: json['sprites']?['other']?['official-artwork']?['front_default'] as String?,
    types: typeNames,
    weight: json['weight'] as int?,
    height: json['height'] as int?,
    exp: json['base_experience'] as int?,
    moves: moveNames
  );
}
}