import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/utils/capitalize.dart';
import 'dart:math' as math;

import '../screens/pokemon_details._screen.dart';

class EvolutionSection extends StatefulWidget {
  final EvolutionChain evolutionChain;
  final PokemonSpecies pokemonSpecies;
  final Pokemon pokemon;
  const EvolutionSection({super.key, required this.evolutionChain, required this.pokemonSpecies, required this.pokemon});

  @override
  State<EvolutionSection> createState() => _EvolutionSectionState();
}

void navigateToPokemonDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => PokemonDetailsScreen(pokemonName: name))
  );
}

class _EvolutionSectionState extends State<EvolutionSection> {
  final pokedex = Pokedex();
  EvolutionChain? evolutionChain;
  Pokemon? pokemon1;
  Pokemon? pokemon2;
  Pokemon? pokemon3;

  @override
  void initState() {
    super.initState();
    _loadEvolutionDetails();
  }

  Future<void> _loadEvolutionDetails()async {
    final res = await pokedex.evolutionChains.getByUrl(widget.pokemonSpecies.evolutionChain.url);
    pokemon1 = await pokedex.pokemon.get(name: res.chain.species.name);
    if(res.chain.evolvesTo.isNotEmpty) {
      pokemon2 = await pokedex.pokemon.get(name: res.chain.evolvesTo.first.species.name);
    }
    if(res.chain.evolvesTo.first.evolvesTo.isNotEmpty) {
      pokemon3 = await pokedex.pokemon.get(name: res.chain.evolvesTo.first.evolvesTo.first.species.name);
    }
    setState(() {
      evolutionChain = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return evolutionChain != null ? SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30,),
          evolutionChain != null ?
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width-30,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      pokemon1 != null ? InkWell(
                        onTap: () => navigateToPokemonDetails(context, pokemon1!.name),
                        child: Column(
                          children: [
                            Image.network(
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon1!.id}.png',
                              height: 100,
                            ),
                            Text(
                              capitalize(evolutionChain!.chain.species.name)
                            ),
                          ],
                        ),
                      ) : const SizedBox(),
                      //an arrow pointing right
                      Column(
                        children: [
                          const SizedBox(height: 20,),
                          Text(
                            evolutionChain!.chain.evolvesTo.first.evolutionDetails.first.minLevel != null ?
                            'Lv.${evolutionChain!.chain.evolvesTo.first.evolutionDetails.first.minLevel}' : '',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 0.5),
                          ),
                          const Icon(Icons.arrow_right_alt, size: 50,),

                        ],
                      ),
                      pokemon2 != null? InkWell(
                        onTap: () => navigateToPokemonDetails(context, pokemon2!.name),
                        child: Column(
                          children: [
                            Image.network(
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon2!.id}.png',
                              height: 100,
                            ),
                            Text(
                                capitalize(evolutionChain!.chain.evolvesTo.first.species.name)
                            ),
                          ],
                        ),
                      ) : const SizedBox(),
                    ],
                  ),
                ),
              ) : const SizedBox(),
          const SizedBox(height: 20,),
          pokemon3 != null ? SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width-30,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  pokemon2 != null ? InkWell(
                    onTap: () => navigateToPokemonDetails(context, pokemon2!.name),
                    child: Column(
                      children: [
                        Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon2!.id}.png',
                          height: 100,
                        ),
                        Text(
                            capitalize(evolutionChain!.chain.evolvesTo.first.species.name)
                        )
                      ],
                    ),
                  ) : const SizedBox(),
                  //an arrow pointing right
                  Column(
                    children: [
                      const SizedBox(height: 20,),
                      Text(

                      evolutionChain!.chain.evolvesTo.first.evolvesTo.first.evolutionDetails.first.minLevel != null?
                       'Lv.${evolutionChain!.chain.evolvesTo.first.evolvesTo.first.evolutionDetails.first.minLevel}' : '',

                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 0.5),
                      ),
                      const Icon(Icons.arrow_right_alt, size: 50,),

                    ],
                  ),
                  InkWell(
                    onTap: () => navigateToPokemonDetails(context, pokemon3!.name),
                    child: Column(
                      children: [
                        Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon3!.id}.png',
                          height: 100,
                        ),
                        Text(
                            capitalize(evolutionChain!.chain.evolvesTo.first.evolvesTo.first.species.name)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ) : const SizedBox(),
        ],

      ),
    ) : SizedBox(
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: math.pi /4 ,
                child: Image.asset(
                    'assets/images/pokeball.png',
                  height: 200,
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.center,
                child: Text('No Evolutions', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)
            ),
          ],
        ),
      ),
    );
  }
}
