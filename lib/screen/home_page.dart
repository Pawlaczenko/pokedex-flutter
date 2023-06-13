import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon.dart';
import 'package:http/http.dart' as http;

import '../widget/pokemon_window_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Pokedex'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'), // Replace 'background.png' with your actual background image file path
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 5,
                  ),
                ),
                padding:EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset(
                  'assets/logo.png', // Replace 'logo.png' with your actual logo image file path
                  width: 250,
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/pokemonList');
                },
                child: Text('Open the Pokedex'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
