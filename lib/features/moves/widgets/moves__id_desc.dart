import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import '../../../global_variables.dart';
import '../../../utils/capitalize.dart';
import '../../pokemon details/screens/pokemon_details._screen.dart';
import '../screens/move_details.dart';

class IDDescMoves extends StatelessWidget {
  final NamedAPIResourceList pokemon;
  const IDDescMoves({super.key, required this.pokemon});

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
          onTap: () => navigateToMoveDetails(context, pokemon.results[reversedIndex].name),
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
void navigateToMoveDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => MoveDetails(moveName: name))
  );
}
