import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import '../../../global_variables.dart';
import '../../../utils/capitalize.dart';
import '../../pokemon details/screens/pokemon_details._screen.dart';

class AtoZPokemon extends StatelessWidget {
  final NamedAPIResourceList pokemon;
  const AtoZPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
      ),
      itemCount: pokemon.results.length,
      itemBuilder: (context, index) {
        final sortedResults = pokemon.results.toList()..sort((a, b) => a.name.compareTo(b.name));
        final pokemonName = capitalize(sortedResults[index].name);
        final pokiUrl = '$imageUrl${sortedResults[index].url.split('/').reversed.toList()[1]}.png';

        return InkWell(
          onTap: () => navigateToPokemonDetails(context, pokemonName),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  pokemonName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    '#${sortedResults[index].url.split('/').reversed.toList()[1].padLeft(3, '0')}'
                ),
                Image.network(
                  pokiUrl,
                  height: 100,
                  width: 100,
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
