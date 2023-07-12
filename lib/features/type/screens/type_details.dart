import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/features/type/widgets/type_button.dart';
import 'package:pokedex_app/utils/capitalize.dart';

class TypeDetails extends StatefulWidget {
  final String typeName;
  final Color textColor;
  final Color backgroundColor;
  const TypeDetails({super.key, required this.typeName, required this.textColor, required this.backgroundColor});

  @override
  State<TypeDetails> createState() => _TypeDetailsState();
}

class _TypeDetailsState extends State<TypeDetails> {

  int error = 0;
  Type? _type;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTypeData(widget.typeName);
  }

  Future<void> _loadTypeData(String name) async{

    final pokedex = Pokedex();

    try{
      final type = await pokedex.types.get(name: name);
      setState(() {
        _type = type;
      });
    }catch (e){
      error = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                capitalize(widget.typeName),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.textColor,
                  shadows: [
                    Shadow(
                      color: widget.textColor,
                      offset: const Offset(0, 0),
                      blurRadius: 100,
                    ),
                  ],
                ),
              ),
              background: Column(
                children: [
                  const SizedBox(height: 60,),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/types/${capitalize(widget.typeName)}.png',
                      fit: BoxFit.contain,
                    )
                  )
                ],
              ),
              )
            ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //double damage from
                ListTile(
                  title: const Text(
                    'Double Damage From',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: _type != null ? _type!.damageRelations.doubleDamageFrom.isNotEmpty ? Wrap(
                    spacing: 10,
                    children: _type!.damageRelations.doubleDamageFrom.map((e) =>
                        TypeButton(typeName: e.name)).toList(),
                  ) : const Text('-')
                      : error == 1 ? Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
                  ) : const Center(child: CircularProgressIndicator()),
                ),

                //damage to
                ListTile(
                  title: const Text(
                    'Double Damage To',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: _type != null ? _type!.damageRelations.doubleDamageTo.isNotEmpty ? Wrap(
                    spacing: 10,
                    children: _type!.damageRelations.doubleDamageTo.map((e) =>
                        TypeButton(typeName: e.name)).toList(),
                  ) : const Text('-')
                      : error == 1 ? Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
                  ) : const Center(child: CircularProgressIndicator()),
                ),

                //half damage from
                ListTile(
                  title: const Text(
                    'Half Damage From',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: _type != null ? _type!.damageRelations.halfDamageFrom.isNotEmpty ? Wrap(
                    spacing: 10,
                    children: _type!.damageRelations.halfDamageFrom.map((e) =>
                        TypeButton(typeName: e.name)).toList(),
                  ) : const Text('-')
                      : error == 1 ? Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
                  ) : const Center(child: CircularProgressIndicator()),
                ),

                //half damage to
                ListTile(
                  title: const Text(
                    'Half Damage To',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: _type != null ? _type!.damageRelations.halfDamageTo.isNotEmpty ? Wrap(
                    spacing: 10,
                    children: _type!.damageRelations.halfDamageTo.map((e) =>
                        TypeButton(typeName: e.name)).toList(),
                  ) : const Text('-')
                      : error == 1 ? Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
                  ) : const Center(child: CircularProgressIndicator()),
                ),

                //no damage from
                ListTile(
                  title: const Text(
                    'No Damage From',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: _type != null ? _type!.damageRelations.noDamageFrom.isNotEmpty ? Wrap(
                    spacing: 10,
                    children: _type!.damageRelations.noDamageFrom.map((e) =>
                        TypeButton(typeName: e.name)).toList(),
                  ) : const Text('-')
                      : error == 1 ? Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
                  ) : const Center(child: CircularProgressIndicator()),
                ),

                //no damage to
                ListTile(
                  title: const Text(
                    'No Damage To',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: _type != null ? _type!.damageRelations.noDamageTo.isNotEmpty ? Wrap(
                    spacing: 10,
                    children: _type!.damageRelations.noDamageTo.map((e) =>
                        TypeButton(typeName: e.name)).toList(),
                  ) : const Text('-')
                      : error == 1 ? Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
                  ) : const Center(child: CircularProgressIndicator()),
                ),

                //generation
                ListTile(
                  title: const Text(
                    'Generation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: _type != null ? Text(
                    capitalize(_type!.generation.name),
                  ) : error == 1 ? Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
                  ) : const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
