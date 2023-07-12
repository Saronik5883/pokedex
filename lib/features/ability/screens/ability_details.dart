import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/utils/capitalize.dart';
import '../../../utils/type_color.dart';

class AbilityDetails extends StatefulWidget {
  final String abilityName;
  const AbilityDetails({super.key, required this.abilityName});

  @override
  State<AbilityDetails> createState() => _AbilityDetailsState();
}

class _AbilityDetailsState extends State<AbilityDetails> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  bool showNotFound = false;
  int error = 0;

  Ability? _ability;
  final TypeColor typeColor = TypeColor();
  List<Color> colors = [Colors.grey, Colors.grey.shade900];


  @override
  void initState() {
    super.initState();
    _loadMoveDetails(widget.abilityName);
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
      final ability = await pokedex.abilities.get(name: name);
      print('CALLED MOVE DETAILS');
      setState(() {
        _ability = ability;
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
      body: error == 0 ? _ability != null ? CustomScrollView(
          slivers: [
            SliverAppBar.large(
              //expandedHeight: 220,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        capitalize(_ability!.name),
                        style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        '  #${_ability!.id.toString().padLeft(3, '0')}',
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(

                  children: [
                    const Text('Ability details',style: TextStyle(fontSize: 20),),


                    SizedBox(
                      width: MediaQuery.of(context).size.width - 25,
                      child: Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading:IconButton.filledTonal(
                                icon: const Icon(Icons.filter_1),
                                onPressed: (){},
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: const Text('Effect Entries'),
                              subtitle: Text(
                                  capitalize(
                                  _ability!
                                      .effectEntries
                                      .firstWhere((element) => element.language.name == 'en')
                                      .effect
                                  )),
                            ),
                            ListTile(
                              leading:IconButton.filledTonal(
                                icon: const Icon(Icons.filter_2),
                                onPressed: (){},
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: const Text('Effect Changes'),
                              subtitle: Text(
                                  _ability!.effectChanges.isNotEmpty ?
                                  capitalize(
                                      _ability!
                                          .effectChanges
                                          .first
                                          .effectEntries
                                          .firstWhere((element) => element.language.name == 'en')
                                          .effect) : '-'),
                            ),
                            ListTile(
                              leading:IconButton.filledTonal(
                                icon: const Icon(Icons.filter_3),
                                onPressed: (){},
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: const Text('Generation'),
                              subtitle: Text(capitalize(_ability!.generation!.name)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
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
