import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/utils/capitalize.dart';

import '../../moves/screens/move_details.dart';

class MovesSection extends StatelessWidget {
  final Pokemon pokemon;
  const MovesSection({super.key, required this.pokemon});

  void navigateToMoveDetails(BuildContext context, String name) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MoveDetails(moveName: name))
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,

            children: [
              for (var i = 0; i < pokemon.moves.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: InkWell(
                    onTap: () => navigateToMoveDetails(context, pokemon.moves[i].move.name),
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        capitalize(pokemon.moves[i].move.name),
                        style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 40,),
        ],

      ),
    );
  }
}
