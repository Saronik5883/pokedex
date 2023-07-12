import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/utils/capitalize.dart';
import 'package:pokedex_app/utils/type_color.dart';
import '../../../global_variables.dart';
import '../../moves/screens/move_details.dart';
import '../../pokemon details/screens/pokemon_details._screen.dart';
import '../widgets/search_ability.dart';
import '../widgets/search_moves.dart';

class SearchPokemon extends StatefulWidget {
  const SearchPokemon({Key? key}) : super(key: key);

  @override
  State<SearchPokemon> createState() => _SearchPokemonState();
}

void navigateToPokemonDetails(BuildContext context, String name) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PokemonDetailsScreen(pokemonName: name)),
  );
}
void navigateToMoveDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => MoveDetails(moveName: name))
  );
}


class _SearchPokemonState extends State<SearchPokemon> {
  final TypeColor typeColor = TypeColor();
  Pokemon? response;
  Move? moveResponse;

  List<Color> typeColors1 = [Colors.grey, Colors.grey.shade900];
  List<Color> typeColor2 = [Colors.grey, Colors.grey.shade900];
  List<List<Color>> typeColors = [
    [Colors.grey, Colors.grey.shade900],
    [Colors.grey, Colors.grey.shade900]
  ];
  int error = 0;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> _loadPokemonDataByName(String pokemonName) async {
    final pokedex = Pokedex();
    late Pokemon? res;
    try {
      res = await pokedex.pokemon.get(name: pokemonName);
      final color1 = await typeColor.typeColor(res.types[0].type.name);
      final color2 = await typeColor.textColor(res.types[0].type.name);

      for (int i = 0; i < res.types.length; i++) {
        typeColors[i] = [
          await typeColor.typeColor(res.types[i].type.name),
          await typeColor.textColor(res.types[i].type.name)
        ];
      }
      setState(() {
        response = res;
        typeColors1 = [color1, color2];
      });
    } catch (e) {
      error = 1;
    }
  }

  Future<void> _loadPokemonDataByID(int pokemonId) async {
    final pokedex = Pokedex();
    late Pokemon? res;
    try {
      res = await pokedex.pokemon.getByUrl('https://pokeapi.co/api/v2/pokemon/$pokemonId/');
      final color1 = await typeColor.typeColor(res.types[0].type.name);
      final color2 = await typeColor.textColor(res.types[0].type.name);

      for (int i = 0; i < res.types.length; i++) {
        typeColors[i] = [
          await typeColor.typeColor(res.types[i].type.name),
          await typeColor.textColor(res.types[i].type.name)
        ];
      }
      setState(() {
        response = res;
        typeColors1 = [color1, color2];
      });
    } catch (e) {
      error = 1;
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            //Column for searching pokemon by ID or Name
            Column(
              children: [
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Search for a Pokemon by ID or Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _idController,
                          decoration: const InputDecoration(
                            labelText: 'Search by ID',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          final String id = _idController.text.trim();
                          if (id.isNotEmpty) {
                            final int pokemonId = int.tryParse(id) ?? 0;
                            _loadPokemonDataByID(pokemonId);
                          }
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Search by Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          final String name = _nameController.text.trim().toLowerCase().replaceAll(' ', '-');
                          if (name.isNotEmpty) {
                            _loadPokemonDataByName(name);
                          }
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                if (response != null)
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListTile(
                      onTap: () => navigateToPokemonDetails(context, response!.name),
                      title: Text(
                        capitalize(response!.name),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Text('ID: #${response!.id.toString().padLeft(3, '0')}'),
                          const SizedBox(width: 16),
                          for(int i=0; i < response!.types.length; i++)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              height: 30,
                              width: 57,
                              decoration: BoxDecoration(
                                color: typeColors[i][0],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 5,),
                                  Text(
                                      capitalize(response!.types[i].type.name),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: typeColors[i][1],
                                      )
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                      trailing: Image.network(
                        '$imageUrl${response!.id}.png',
                        height: 100,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20,),

            //Column for searching moves by ID or Name
            const MoveSearch(),

            const SizedBox(height: 20,),

            //Column for searching abilities by Id or name
            const AbilitySearch(),
          ],
        ),
      ),
    );
  }
}
