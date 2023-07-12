import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import '../../../utils/capitalize.dart';
import '../screens/ability_details.dart';


class IDDescAbility extends StatelessWidget {
  final NamedAPIResourceList pokemon;
  const IDDescAbility({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
      ),
      itemCount: pokemon.results.length,
      itemBuilder: (context, index) {
        final reversedIndex = pokemon.results.length - index - 1; // Reverse the iteration
        return InkWell(
          onTap: () => navigatToAbilityDetails(context, pokemon.results[reversedIndex].name),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  capitalize(pokemon.results[reversedIndex].name),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '#${(reversedIndex + 1).toString().padLeft(3, '0')}',
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
