import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import '../../../utils/capitalize.dart';
import '../screens/ability_details.dart';

class AtoZAbility extends StatelessWidget {
  final NamedAPIResourceList pokemon;
  const AtoZAbility({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
      ),
      itemCount: pokemon.results.length,
      itemBuilder: (context, index) {
        final sortedResults = pokemon.results.toList()..sort((a, b) => a.name.compareTo(b.name));
        final pokemonName = capitalize(sortedResults[index].name);


        return InkWell(
          onTap: () => navigatToAbilityDetails(context, pokemonName),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  pokemonName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    '#${sortedResults[index].url.split('/').reversed.toList()[1].padLeft(3, '0')}'
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void navigatToAbilityDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => AbilityDetails(abilityName: name))
  );
}