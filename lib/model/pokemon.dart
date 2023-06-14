import 'dart:core';

class Pokemon {
  final String name;
  final int id;
  final String? sprite;
  final List<dynamic> types;

  Pokemon({required this.name, required this.id, required this.sprite, required this.types});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
  final List<dynamic> typesJson = json['types'] ?? [];
  final List<String> typeNames = typesJson
    .map((typeJson) => typeJson['type']['name'] as String)
    .toList();

  return Pokemon(
    name: json['name'] as String,
    id: json['id'] as int,
    sprite: json['sprites']?['front_default'] as String?,
    types: typeNames,
  );
}
}