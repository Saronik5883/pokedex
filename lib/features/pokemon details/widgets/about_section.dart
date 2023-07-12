import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/utils/capitalize.dart';

class AboutSection extends StatelessWidget {
  final PokemonSpecies pokemonSpecies;
  final Pokemon pokemon;
  const AboutSection({super.key, required this.pokemon, required this.pokemonSpecies});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              //islegendary or mythical
              Row(
                children: [
                  pokemonSpecies.isLegendary ? SizedBox(
                    height: 60,
                    width: 167,
                    child: Card(
                      child: ListTile(
                        leading: const Icon(
                            Icons.star,
                            color: Colors.amber
                        ),
                        title: Text('Legendary', style: TextStyle(color: Colors.amberAccent.shade100),),
                      ),
                    ),
                  ) : const SizedBox.shrink(),
                  pokemonSpecies.isMythical ? SizedBox(
                    height: 60,
                    width: 167,
                    child: Card(
                      child: ListTile(
                        leading: const Icon(
                            Icons.star,
                            color: Colors.deepOrangeAccent
                        ),
                        title: Text('Mythical', style: TextStyle(color: Colors.deepOrangeAccent.shade100),),
                      ),
                    ),
                  ) : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 5,),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    pokemonSpecies.flavorTextEntries.firstWhere(
                        (element) => element.language.name == 'en')
                        .flavorText.replaceAll('\n', ' ').replaceAll('\f', ' ') + pokemonSpecies.flavorTextEntries.lastWhere(
                            (element) => element.language.name == 'en')
                        .flavorText.replaceAll('\n', ' ').replaceAll('\f', ' ')
                  ),
                ),
              const SizedBox(height: 20,),
              //height and weight
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2.4,
                    height: 70,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 5,),
                          IconButton.filledTonal(
                              icon: const Icon(Icons.height),
                              onPressed: (){},
                              style: IconButton.styleFrom(
                                foregroundColor: Theme.of(context).colorScheme.primary,
                              )
                          ),
                          const SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Height', style: TextStyle(fontWeight: FontWeight.w500),),
                              Text('${pokemon.height / 10} m', style: const TextStyle(fontSize: 18),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2.4,
                    height: 70,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 5,),
                          IconButton.filledTonal(
                              icon: const Icon(Icons.scale),
                              onPressed: (){},
                              style: IconButton.styleFrom(
                                foregroundColor: Theme.of(context).colorScheme.primary,
                              )
                          ),
                          const SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Weight', style: TextStyle(fontWeight: FontWeight.w500),),
                              Text('${pokemon.weight / 10} kg', style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Text('First Appearance', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
              const SizedBox(height: 10,),
              Text(
                'Pokemon ${capitalize(pokemon.gameIndices.first.version.name)} & ${capitalize(pokemon.gameIndices[1].version.name)}',
                  style: TextStyle(color: Theme.of(context).colorScheme.outline)
              ),
              const SizedBox(height: 20,),
              const Text('Breeding', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
              //gender, egg groups and egg cycle
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text('Gender Rate', style: TextStyle(color: Theme.of(context).colorScheme.outline),),
                  const SizedBox(width: 46,),
                  Text(pokemonSpecies.genderRate.toString()),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text('Egg Groups', style: TextStyle(color: Theme.of(context).colorScheme.outline),),
                  const SizedBox(width: 50,),
                  for(int i=0; i<pokemonSpecies.eggGroups.length; i++)
                    Text(capitalize(pokemonSpecies.eggGroups[i].name) + capitalize(i == pokemonSpecies.eggGroups.length - 1 ? '' : '  ')),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text('Hatch Counter', style: TextStyle(color: Theme.of(context).colorScheme.outline),),
                  const SizedBox(width: 30,),
                  Text(pokemonSpecies.hatchCounter.toString() + ' steps'),
                ],
              ),
              const SizedBox(height: 20,),
              const Text('Sprites', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
              //sprites
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.network(
                      pokemon.sprites.frontDefault!,
                      height: 100,
                      width: 100,
                    ),
                    Image.network(
                      pokemon.sprites.backDefault!,
                      height: 100,
                      width: 100,
                    ),
                    pokemon.sprites.frontShiny != null ? Image.network(
                      pokemon.sprites.frontShiny!,
                      height: 100,
                      width: 100,
                    ) : const SizedBox(),
                    pokemon.sprites.backShiny != null ? Image.network(
                      pokemon.sprites.backShiny!,
                      height: 100,
                      width: 100,
                    ) : const SizedBox(),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}
