import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/features/moves/screens/move_details.dart';

import '../../../global_variables.dart';
import '../../../utils/capitalize.dart';
import '../../pokemon details/screens/pokemon_details._screen.dart';

class IDAsecMoves extends StatefulWidget {
  final NamedAPIResourceList move;
  const IDAsecMoves({super.key, required this.move});

  @override
  State<IDAsecMoves> createState() => _IDAsecMovesState();
}

void navigateToMoveDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => MoveDetails(moveName: name))
  );
}

class _IDAsecMovesState extends State<IDAsecMoves> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
            ),
            itemCount: widget.move.results.length,
            itemBuilder: (context, index) => 
                InkWell(
                  onTap: () => navigateToMoveDetails(context, widget.move.results[index].name),
                  child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        capitalize(widget.move!.results[index].name),
                        style: const TextStyle(
                          //fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          '#${(index+1).toString().padLeft(3, '0')}'
                      ),
                    ],
                  )
            ),
                ),
          );

  }
}
