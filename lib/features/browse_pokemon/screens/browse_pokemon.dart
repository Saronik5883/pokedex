import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/features/browse_pokemon/widgets/pokemon__id_desc.dart';
import 'package:pokedex_app/features/browse_pokemon/widgets/pokemon_a_z.dart';
import 'package:pokedex_app/features/browse_pokemon/widgets/pokemon_z_to_a.dart';
import 'package:pokedex_app/utils/capitalize.dart';

import '../../../global_variables.dart';
import '../widgets/pokemon_id_asec.dart';
import 'browse_all_pokemon.dart';

class BrowsePokemon extends StatefulWidget {
  const BrowsePokemon({super.key});

  @override
  State<BrowsePokemon> createState() => _BrowsePokemonState();
}

void navigateToAllPokemon(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const BrowseAllPokemon())
  );
}


class _BrowsePokemonState extends State<BrowsePokemon> {
  NamedAPIResourceList? pokemon;
  int offset = 0;
  int limit = 20;
  int segmentedButtonIndex = 0;
  int sortIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPokemon(offset, limit);
  }

  Future<void> _loadPokemon(int offset, int limit) async {
    final pokedex = Pokedex();
    final pokemon = await pokedex.pokemon.getPage(offset: offset, limit: limit);
    setState(() {
      this.pokemon = pokemon;
    });
  }

  @override
  Widget build(BuildContext context) {

    String selectedOption = '1-20'; // Default selected option

    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Pokemon'),
        actions: [
          IconButton(onPressed: () => navigateToAllPokemon(context), icon: Icon(Icons.language)),
          Builder(
              builder: (context) {
                return Row(
                  children: [
                    PopupMenuButton<String>(
                      initialValue: selectedOption,
                      onSelected: (String? newValue) {
                        setState(() {
                          selectedOption = newValue!;
                        });

                        if (selectedOption == 'ID (Asc)') {
                          setState(() {
                            sortIndex = 0;
                          });
                        } else if (selectedOption == 'ID (Des)') {
                          setState(() {
                            sortIndex = 1;
                          });
                        } else if (selectedOption == 'A-Z') {
                          setState(() {
                            sortIndex = 2;
                          });
                        } else if (selectedOption == 'Z-A') {
                          setState(() {
                            sortIndex = 3;
                          });
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'ID (Asc)',
                          child: ListTile(
                            leading: Icon(Icons.bar_chart_outlined),
                            title: Text('ID (Asc)'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'ID (Des)',
                          child: ListTile(
                            leading: Icon(Icons.stacked_bar_chart),
                            title: Text('ID (Des)'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'A-Z',
                          child: ListTile(
                            leading: Icon(Icons.text_rotate_vertical),
                            title: Text('A-Z'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Z-A',
                          child: ListTile(
                            leading: Icon(Icons.text_rotate_up),
                            title: Text('Z-A'),
                          ),
                        ),
                      ],
                      child: const Row(
                        children: [
                          SizedBox(width: 5),
                          Icon(Icons.sort),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    //number of results
                    PopupMenuButton<String>(
                      initialValue: selectedOption,
                      onSelected: (String? newValue) {
                        setState(() {
                          selectedOption = newValue!;
                        });

                        if (selectedOption == '1-20') {
                          _loadPokemon(0, 20);
                        } else if (selectedOption == '1-100') {
                          _loadPokemon(0, 100);
                        } else if (selectedOption == '1-200') {
                          _loadPokemon(0, 200);
                        } else if (selectedOption == 'All') {
                          _loadPokemon(0, 538);
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: '1-20',
                          child: ListTile(
                            leading: Icon(Icons.twenty_mp),
                            title: Text('1-20'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: '1-100',
                          child: ListTile(
                            leading: Icon(Icons.linear_scale),
                            title: Text('1-100'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: '1-200',
                          child: ListTile(
                            leading: Icon(Icons.all_inbox_outlined),
                            title: Text('1-200'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'All',
                          child: ListTile(
                            leading: Icon(Icons.all_inclusive),
                            title: Text('All'),
                          ),
                        ),
                      ],
                      child: const Row(
                        children: [
                          SizedBox(width: 5),
                          Icon(Icons.more_vert),
                        ],
                      ),
                    ),

                  ],
                );
              },
            ),
        ],
        
      ),
      body: pokemon != null ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: sortIndex == 0 ? IDAsecPokemon(pokemon: pokemon!)
              : sortIndex == 1 ? IDDescPokemon(pokemon: pokemon!)
              : sortIndex == 2 ? AtoZPokemon(pokemon: pokemon!)
              : sortIndex == 3 ? ZtoAPokemon(pokemon: pokemon!) : IDAsecPokemon(pokemon: pokemon!)
        ),
      )
        :  const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
