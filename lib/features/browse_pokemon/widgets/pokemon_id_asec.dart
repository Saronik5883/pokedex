import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import '../../../global_variables.dart';
import '../../../utils/capitalize.dart';
import '../../pokemon details/screens/pokemon_details._screen.dart';

class IDAsecPokemon extends StatelessWidget {
  final NamedAPIResourceList pokemon;
  const IDAsecPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
            ),
            itemCount: pokemon.results.length,
            itemBuilder: (context, index) =>
                InkWell(
                  onTap: () => navigateToPokemonDetails(context, pokemon.results[index].name),
                  child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        capitalize(pokemon!.results[index].name),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          '#${(index+1).toString().padLeft(3, '0')}'
                      ),
                      Image.network(
                        '$imageUrl${index+1}.png',
                        height: 100,
                        width: 100,
                      ),
                    ],
                  )
            ),
                ),
          );

  }
}

void navigateToPokemonDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => PokemonDetailsScreen(pokemonName: name))
  );
}
