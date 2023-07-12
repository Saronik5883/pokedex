import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/features/type/screens/type_details.dart';
import 'package:pokedex_app/utils/capitalize.dart';

import '../../../utils/type_color.dart';

class MoveDetails extends StatefulWidget {
  final String moveName;
  const MoveDetails({super.key, required this.moveName});

  @override
  State<MoveDetails> createState() => _MoveDetailsState();
}

void navigateToTypeDetails(BuildContext context, String name, Color textColor, Color backgroundColor) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => TypeDetails(
          typeName: name,
        textColor: textColor,
        backgroundColor: backgroundColor,
      ))
  );
}

class _MoveDetailsState extends State<MoveDetails> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  bool showNotFound = false;
  int error = 0;

  Move? _move;
  final TypeColor typeColor = TypeColor();
  List<Color> colors = [Colors.grey, Colors.grey.shade900];


  @override
  void initState() {
    super.initState();
    _loadMoveDetails(widget.moveName);
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    Timer(const Duration(seconds: 10), () {
      setState(() {
        showNotFound = true;
      });
    });
  }

  Future<void> _loadMoveDetails(String name) async {
    try{
      final pokedex = Pokedex();
      final move = await pokedex.moves.get(name: name);
      final getColors = [await typeColor.typeColor(move.type.name), await typeColor.textColor(move.type.name)];
      print('CALLED MOVE DETAILS');
      setState(() {
        _move = move;
        colors = getColors;
      });
    }catch(e){
      setState(() {
        error = 1;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: error == 0 ? _move != null ? CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        capitalize(_move!.name),
                        style: TextStyle(
                            fontSize: 24,
                            color: colors[0],
                            fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: colors[0],
                              offset: const Offset(0, 0),
                              blurRadius: 100,
                            ),
                          ],

                        ),
                      ),
                      Text(
                        '  #${_move!.id.toString().padLeft(3, '0')}',
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            InkWell(
                              onTap: () => navigateToTypeDetails(
                                  context, _move!.type.name.toLowerCase(),
                                  colors[0], colors[1],
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: colors[0],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: AssetImage(
                                          'assets/images/types/${capitalize(_move!.type.name)}.png'
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    Text(
                                        capitalize(_move!.type.name),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colors[1],
                                        )
                                    )
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
            ),

          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(

                children: [
                  const SizedBox(height: 20,),
                  const Text('Move details',style: TextStyle(fontSize: 20),),

                  //accuracy and power
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
                                  icon: const Icon(Icons.track_changes),
                                  onPressed: (){},
                                  style: IconButton.styleFrom(
                                    foregroundColor: Theme.of(context).colorScheme.primary,
                                  )
                              ),
                              const SizedBox(width: 20,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Accuracy', style: TextStyle(fontWeight: FontWeight.w500),),
                                  Text(_move?.accuracy != null ? '${_move!.accuracy}%' : '-', style: const TextStyle(fontSize: 18),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1,
                        height: 70,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.outline,
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
                                  icon: const Icon(Icons.back_hand),
                                  onPressed: (){},
                                  style: IconButton.styleFrom(
                                    foregroundColor: Theme.of(context).colorScheme.primary,
                                  )
                              ),
                              const SizedBox(width: 20,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Power', style: TextStyle(fontWeight: FontWeight.w500),),
                                  Text(_move?.power != null ? '${_move!.power}' : '-', style: const TextStyle(fontSize: 18)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //pp, priority
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
                                  icon: const Icon(Icons.timelapse),
                                  onPressed: (){},
                                  style: IconButton.styleFrom(
                                    foregroundColor: Theme.of(context).colorScheme.primary,
                                  )
                              ),
                              const SizedBox(width: 20,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('PP', style: TextStyle(fontWeight: FontWeight.w500),),
                                  Text('${_move!.pp}', style: const TextStyle(fontSize: 18),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1,
                        height: 70,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.outline,
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
                                  icon: const Icon(Icons.list_alt),
                                  onPressed: (){},
                                  style: IconButton.styleFrom(
                                    foregroundColor: Theme.of(context).colorScheme.primary,
                                  )
                              ),
                              const SizedBox(width: 20,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Priority', style: TextStyle(fontWeight: FontWeight.w500),),
                                  Text('${_move!.priority}', style: const TextStyle(fontSize: 18),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width - 25,
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading:IconButton.filledTonal(
                              icon: const Icon(Icons.filter_2),
                              onPressed: (){},
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: const Text('Effect Entries'),
                            subtitle: Text(capitalize(_move!.effectEntries.first.shortEffect.replaceAll('\$effect_chance',_move!.effectChance != null ? _move!.effectChance.toString() : "-"))),
                          ),
                          ListTile(
                            leading:IconButton.filledTonal(
                              icon: const Icon(Icons.filter_3),
                              onPressed: (){},
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: const Text('Effect Changes'),
                            subtitle: Text(_move!.effectChanges.isNotEmpty ? capitalize(_move!.effectChanges.first.effectEntries.first.effect) : '-'),
                          ),
                          ListTile(
                            leading:IconButton.filledTonal(
                              icon: const Icon(Icons.filter_3),
                              onPressed: (){},
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: const Text('Effect Chance'),
                            subtitle: Text(_move!.effectChance != null ? capitalize(_move!.effectChance.toString()) : '-'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  title: const Text('Target'),
                  subtitle: Text(capitalize(_move!.target!.name)),
                ),

                ListTile(
                  title: const Text('Damage Class'),
                  subtitle: Text(capitalize(_move!.damageClass!.name)),
                ),
                ListTile(
                  title: const Text('Generation'),
                  subtitle: Text(capitalize(_move!.generation!.name)),
                ),
                ListTile(
                  title: const Text('Stat Changes'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(int i=0; i<_move!.statChanges.length; i++)
                        Text('${capitalize(_move!.statChanges[i].stat.name)}: ${_move!.statChanges[i].change}')
                    ],
                  )
                ),
        ],
      ),
      )
        ]
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
        ),)
            : CustomScrollView(
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
