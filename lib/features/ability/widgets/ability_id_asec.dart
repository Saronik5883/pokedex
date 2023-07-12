import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import '../../../utils/capitalize.dart';
import '../screens/ability_details.dart';

class IDAsecAbility extends StatefulWidget {
  final NamedAPIResourceList move;
  const IDAsecAbility({super.key, required this.move});

  @override
  State<IDAsecAbility> createState() => _IDAsecAbilityState();
}


class _IDAsecAbilityState extends State<IDAsecAbility> {
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
                  onTap: () => navigatToAbilityDetails(context, widget.move.results[index].name),
                  child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        capitalize(widget.move.results[index].name),
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

void navigatToAbilityDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => AbilityDetails(abilityName: name))
  );
}
