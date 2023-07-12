import 'package:flutter/material.dart';
import 'package:pokedex_app/features/type/widgets/type_widget.dart';

class BrowseTypes extends StatelessWidget {
  const BrowseTypes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Browse Types')
          ),
          const SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    //normal
                    TypeWidget(
                        typeName: 'Normal',
                        fontColor: Color(0xFF3A3A2B),
                        cardColor: Color(0xFFA8A878),
                    ),

                    //flying
                    TypeWidget(
                        typeName: 'Flying',
                        fontColor: Color(0xFF544672),
                        cardColor: Color(0xFFA890F0),
                    ),

                    //ground
                    TypeWidget(
                        typeName: 'Ground',
                        fontColor: Color(0xFF483B23),
                        cardColor: Color(0xFFE0C068),
                    ),

                    //bug
                    TypeWidget(
                        typeName: 'Bug',
                        fontColor: Color(0xFF48500F),
                        cardColor: Color(0xFFA8B820),
                    ),

                    //steel
                    TypeWidget(
                        typeName: 'Steel',
                        fontColor: Color(0xFF434359),
                        cardColor: Color(0xFFB8B8D0),
                    ),

                    //water
                    TypeWidget(
                        typeName: 'Water',
                        fontColor:Color(0xFF142850),
                        cardColor: Color(0xFF6890F0),
                    ),

                    //electric
                    TypeWidget(
                        typeName: 'Electric',
                        fontColor: Color(0xFF6E5713),
                        cardColor: Color(0xFFF8D030),
                    ),

                    //ice
                    TypeWidget(
                        typeName: 'Ice',
                        fontColor: Color(0xFF295050),
                        cardColor: Color(0xFF98D8D8),
                    ),

                    //dark
                    TypeWidget(
                        typeName: 'Dark',
                        fontColor: Color(0xFF3A2920),
                        cardColor: Color(0xFF705848),
                    ),
                  ]
                ),
                Column(
                    children: [
                      //normal
                      TypeWidget(
                        typeName: 'Fighting',
                        fontColor: Color(0xFF420B08),
                        cardColor: Color(0xFFC03028),
                      ),

                      //flying
                      TypeWidget(
                        typeName: 'Poison',
                        fontColor: Color(0xFF4D2A4D),
                        cardColor: Color(0xFFA040A0),
                      ),

                      //ground
                      TypeWidget(
                        typeName: 'Rock',
                        fontColor: Color(0xFF4A3B31),
                        cardColor: Color(0xFFB8A038),
                      ),

                      //bug
                      TypeWidget(
                        typeName: 'Ghost',
                        fontColor: Color(0xFF32243F),
                        cardColor: Color(0xFF705898),
                      ),

                      //steel
                      TypeWidget(
                        typeName: 'Fire',
                        fontColor: Color(0xFF673615),
                        cardColor: Color(0xFFF08030),
                      ),

                      //water
                      TypeWidget(
                        typeName: 'Grass',
                        fontColor:Color(0xFF1B4E2B),
                        cardColor: Color(0xFF78C850),
                      ),

                      //electric
                      TypeWidget(
                        typeName: 'Psychic',
                        fontColor: Color(0xFF592D1F),
                        cardColor: Color(0xFFF85888),
                      ),

                      //ice
                      TypeWidget(
                        typeName: 'Dragon',
                        fontColor: Color(0xFF2D1869),
                        cardColor: Color(0xFF7038F8),
                      ),

                      //dark
                      TypeWidget(
                        typeName: 'Fairy',
                        fontColor: Color(0xFF6D3A39),
                        cardColor: Color(0xFFEE99AC),
                      ),
                    ]
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
