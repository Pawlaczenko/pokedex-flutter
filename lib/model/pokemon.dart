import 'dart:core';

class Pokemon {
  final String name;
  final int id;
  final String sprite;

  Pokemon({required this.name, required this.id, required this.sprite});

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    name: json["name"],
    id: json["id"],
    sprite: json["sprites"]["other"]["official-artwork"]["front_default"]
  );
}