import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';



class PokemonRepo {
  Future<void> getByName(String query) async {
    // var response = await PokeAPI.getObject<Pokemon>(1);
    // print(response!.name);

    final pokedex = Pokedex();
    final response = await pokedex.pokemon.get(name: 'ditto');
    print(response);
  }
}