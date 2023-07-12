import 'package:flutter/material.dart';
import 'package:pokedex_app/features/type/screens/browse_types.dart';
import 'package:pokedex_app/utils/type_color.dart';


import '../../ability/screens/browse_abilities.dart';
import '../../browse_pokemon/screens/browse_pokemon.dart';
import '../../moves/screens/browse_moves.dart';
import '../../pokemon details/screens/pokemon_details._screen.dart';
import '../../search/screens/search_pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

void navigateToPokemonDetails(BuildContext context, String name) {
  Navigator.push(context,
    MaterialPageRoute(builder: (context) => PokemonDetailsScreen(pokemonName: name))
  );
}

void navigateToBrowsePokemon(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const BrowsePokemon())
  );
}

void navigateToSearchPokemon(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const SearchPokemon())
  );
}

void navigateToBrowseMoves(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const BrowseMoves())
  );
}

void navigateToBrowseAbilities(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const BrowseAbilities())
  );
}

void navigateToBrowseTypes(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const BrowseTypes())
  );
}

class _HomePageState extends State<HomePage> {

  final TypeColor typeColor = TypeColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            title: const Text('Pokedex'),
            floating: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => navigateToSearchPokemon(context),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children:[
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width-30,
                  child: Card(
                    color: Colors.greenAccent,
                    child: ListTile(
                      leading: Image.asset('assets/images/pokeball.png',
                        color: Colors.green.shade900,),
                      title: Text('Pokemon',
                        style: TextStyle(
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('Browse Pokemon',
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.black87),
                      onTap: () => navigateToBrowsePokemon(context),
                    )
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width-30,
                  child: Card(
                      color: Colors.deepPurpleAccent,
                      child: ListTile(
                        leading: Image.asset('assets/images/pokeball.png',
                          color: Colors.deepPurple.shade900,),
                        title: Text('Moves',
                          style: TextStyle(
                            color: Colors.deepPurple.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('Browse Moves',
                          style: TextStyle(
                            color: Colors.deepPurple.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.black87,),
                        onTap: () => navigateToBrowseMoves(context),
                      )
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width-30,
                  child: Card(
                      color: Colors.orangeAccent,
                      child: ListTile(
                        leading: Image.asset('assets/images/pokeball.png',
                          color: Colors.orange.shade900,),
                        title: Text('Abilities',
                          style: TextStyle(
                            color: Colors.orange.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('Browse Ablitites',
                          style: TextStyle(
                            color: Colors.orange.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.black87),
                        onTap: () => navigateToBrowseAbilities(context),
                      )
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width-30,
                  child: Card(
                      color: Colors.lightBlueAccent,
                      child: ListTile(
                        leading: Image.asset('assets/images/pokeball.png',
                          color: Colors.lightBlue.shade900,),
                        title: Text('Types',
                          style: TextStyle(
                            color: Colors.lightBlue.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('Browse Types',
                          style: TextStyle(
                            color: Colors.lightBlue.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.black87),
                        onTap: () => navigateToBrowseTypes(context),
                      )
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    fit: BoxFit.cover,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  )
                ),
              ]
            ),
          )
        ],
      )
    );
  }
}
