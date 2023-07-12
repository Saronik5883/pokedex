
import 'dart:async';

import 'package:pokedex/pokedex.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/features/pokemon%20details/widgets/about_section.dart';
import 'package:pokedex_app/features/pokemon%20details/widgets/moves_section.dart';
import 'package:pokedex_app/features/type/screens/type_details.dart';
import 'package:pokedex_app/utils/capitalize.dart';
import 'package:pokedex_app/utils/type_color.dart';

import '../widgets/base_stats_section.dart';
import '../widgets/evolution_section.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final String pokemonName;
  final int? pokemonId;
  const PokemonDetailsScreen({Key? key, required this.pokemonName, this.pokemonId}) : super(key: key);

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

void navigateToTypeDetails(BuildContext context, String name, Color textColor, Color backgroundColor) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => TypeDetails(typeName: name, textColor: textColor, backgroundColor: backgroundColor,))
  );
}


class _PokemonDetailsScreenState extends State<PokemonDetailsScreen>
  with TickerProviderStateMixin{
  late AnimationController _animationController;
  final TypeColor typeColor = TypeColor();
  int error = 0;
  Pokemon? response;
  Encounter? encounter;
  Characteristic? chars;
  PokemonSpecies? pokemonSpecies;
  EvolutionChain? evolutionChain;
  String? image;
  late TabController _tabController;
  Color? buttonColor;
  Color? textColor;
  List<Color> typeColors1 = [Colors.grey, Colors.grey.shade900];
  List<Color> typeColor2 = [Colors.grey, Colors.grey.shade900];
  List<List<Color>> typeColors = [
    [Colors.grey, Colors.grey.shade900],
    [Colors.grey, Colors.grey.shade900]
  ];

  bool showNotFound = false;

  @override
  void initState() {
    super.initState();
    _loadPokemonData(widget.pokemonName);
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _tabController = TabController(length: 4, vsync: this);

    Timer(const Duration(seconds: 10), () {
      setState(() {
        showNotFound = true;
      });
    });
  }

  Future<void> _loadPokemonData(String pokemonName) async {
    final pokedex = Pokedex();
    late Pokemon? res;
    try{
      if(widget.pokemonId != null){
        res = await pokedex.pokemon.getByUrl('https://pokeapi.co/api/v2/pokemon/${widget.pokemonId}/');
      }else{
        res = await pokedex.pokemon.get(name: pokemonName);
      }
      final species = await pokedex.pokemonSpecies.get(name: pokemonName);
      final evolution = await pokedex.evolutionChains.get(res.id);
      final color1 = await typeColor.typeColor(res.types[0].type.name);
      final color2 = await typeColor.textColor(res.types[0].type.name);

      for(int i=0; i<res.types.length; i++){
        typeColors[i] = [await typeColor.typeColor(res.types[i].type.name), await typeColor.textColor(res.types[i].type.name)];
      }
      setState(() {
        response = res;
        typeColors1 = [color1, color2];
        pokemonSpecies = species;
        evolutionChain = evolution;
      });
    }catch(e){
      error = 1;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: error == 0 ? response != null ?
        NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) =>[
              SliverAppBar.large(
                expandedHeight: 360,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                title: Text(capitalize(response!.name)),
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${capitalize(response!.name)} ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer
                          ),
                        ),
                        Text(
                          '#${response!.id.toString().padLeft(3, '0')}',
                          style: TextStyle(
                            fontSize: 16,
                              color: Theme.of(context).colorScheme.primary
                          ),
                        )
                      ],
                    ),
                  ),
                    centerTitle: true,
                    background: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50,),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 200,
                        //width: MediaQuery.of(context).size.width-20,
                        width: 200,
                        decoration: BoxDecoration(
                          //color: typeColors1[0].withAlpha(240),
                          //borderRadius: BorderRadius.circular(20),
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: typeColors1[0].withOpacity(0.2),
                              blurRadius: 100,
                              offset: const Offset(0, 5),
                            ),
                          ],

                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage(
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${response!.id}.png'
                            ),
                          ),

                        ),
                        /*child: Stack(
                          children: [
                            Positioned(
                              left: MediaQuery.of(context).size.width/4.3,
                              child: Image.asset(
                                'assets/images/pokeball.png',
                                height: 200,
                                width: 200,
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            Positioned(
                              top: 130,
                              left: MediaQuery.of(context).size.width/2,
                              child: Image.asset(
                                'assets/images/dotted.png',
                                height: 100,
                                width: 100,
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width/4.3,
                              child: Image.asset(
                                'assets/images/dotted.png',
                                height: 100,
                                width: 100,
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width/4.3,
                              child: Image.network(
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${widget.pokemonId}.png',
                                height: 200,
                                width: 200,
                              ),
                            ),
                          ],
                        ),*/
                      ),
                      const SizedBox(height: 68,),
                      //type buttons
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           for(int i=0; i < response!.types.length; i++)
                            InkWell(
                              onTap: () => navigateToTypeDetails(
                                  context, response!.types[i].type.name,
                                  typeColors[i][0], typeColors[i][1]
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: typeColors[i][0],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: AssetImage(
                                        'assets/images/types/${capitalize(response!.types[i].type.name)}.png'
                                      ),
                                    ),
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
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'About'),
                    Tab(text: 'Base Stats'),
                    Tab(text: 'Evolution'),
                    Tab(text: 'Moves'),
                  ],
                ),
              )
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                AboutSection(pokemon: response!, pokemonSpecies: pokemonSpecies!,),
                BaseStatsSection(pokemon: response!, pokemonSpecies: pokemonSpecies!),
                EvolutionSection(evolutionChain: evolutionChain!, pokemon: response!, pokemonSpecies: pokemonSpecies!),
                MovesSection(pokemon: response!),
              ],
            )
        )
          : Center(
            child: Visibility(
              replacement: const Center(child: Text('Pokemon not found')),
              visible: !showNotFound,
              child: RotationTransition(
                turns: _animationController,
                child: Image.asset(
                'assets/images/pokeball.png',
                height: 200,
                color: Theme.of(context).colorScheme.primary,
              ),
          ),
            ),) : CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Pokemon not found'),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Image.asset(
                      'assets/images/pokeball.png',
                      height: 200,
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
