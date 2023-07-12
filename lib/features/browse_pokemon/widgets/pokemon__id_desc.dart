import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import '../../../global_variables.dart';
import '../../../utils/capitalize.dart';
import '../../pokemon details/screens/pokemon_details._screen.dart';

class IDDescPokemon extends StatelessWidget {
  final NamedAPIResourceList pokemon;
  const IDDescPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
      ),
      itemCount: pokemon.results.length,
      itemBuilder: (context, index) {
        final reversedIndex = pokemon.results.length - index - 1; // Reverse the iteration
        return InkWell(
          onTap: () => navigateToPokemonDetails(context, pokemon.results[reversedIndex].name),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  capitalize(pokemon.results[reversedIndex].name),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '#${(reversedIndex + 1).toString().padLeft(3, '0')}',
                ),
                Image.network(
                  '$imageUrl${reversedIndex + 1}.png',
                  height: 100,
                  width: 100,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
void navigateToPokemonDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => PokemonDetailsScreen(pokemonName: name))
  );
}
