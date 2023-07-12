import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import '../../../global_variables.dart';
import '../../../utils/capitalize.dart';
import '../../pokemon details/screens/pokemon_details._screen.dart';

class AllIDAsecPokemon extends StatelessWidget {
  final NamedAPIResourceList pokemon;
  const AllIDAsecPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemCount: 20,
      itemBuilder: (context, index) =>
          Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      capitalize(pokemon!.results[index].name),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        '#${index.toString().padLeft(3, '0')}'
                    ),
                    Image.network(
                      '$imageUrl${index+1}.png',
                      height: 60,
                      width: 60,
                    ),
                  ],
                )
            ),
    );

  }
}
