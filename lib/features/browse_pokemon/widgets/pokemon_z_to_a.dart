import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import '../../../global_variables.dart';
import '../../../utils/capitalize.dart';
import '../../pokemon details/screens/pokemon_details._screen.dart';

class ZtoAPokemon extends StatefulWidget {
  final NamedAPIResourceList pokemon;
  const ZtoAPokemon({super.key, required this.pokemon});

  @override
  State<ZtoAPokemon> createState() => _ZtoAPokemonState();
}

class _ZtoAPokemonState extends State<ZtoAPokemon> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
      ),
      itemCount: widget.pokemon.results.length,
      itemBuilder: (context, index) {
        final sortedResults = widget.pokemon.results.toList()..sort((b, a) => a.name.compareTo(b.name));
        final pokemonName = capitalize(sortedResults[index].name);
        final query = sortedResults[index].url.split('/').reversed.toList()[1];
        if(kDebugMode){
          print('query: $query');
        }
        final pokiUrl = '$imageUrl${sortedResults[index].url.split('/').reversed.toList()[1]}.png';

        return InkWell(
          onTap: () => navigateToPokemonDetails(context, query),
          child: Card(
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
