import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import '../../../global_variables.dart';
import '../../../utils/capitalize.dart';
import '../../pokemon details/screens/pokemon_details._screen.dart';

class AllZtoAPokemon extends StatelessWidget {
  final NamedAPIResourceList pokemon;
  const AllZtoAPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemCount: pokemon.results.length,
      itemBuilder: (context, index) {
        final sortedResults = pokemon.results.toList()..sort((b, a) => a.name.compareTo(b.name));
        final pokemonName = capitalize(sortedResults[index].name);
        final query = sortedResults[index].url.split('/').reversed.toList()[1];
        if(kDebugMode){
          print('query: $query');
        }
        final pokiUrl = '$imageUrl${sortedResults[index].url.split('/').reversed.toList()[1]}.png';

        return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '$pokemonName',
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
                  height: 60,
                  width: 60,
                ),
              ],
            ),
          );
      },
    );
  }
}
