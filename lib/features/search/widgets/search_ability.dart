import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import '../../../utils/capitalize.dart';
import '../../../utils/type_color.dart';
import '../../ability/screens/ability_details.dart';
import '../../moves/screens/move_details.dart';

class AbilitySearch extends StatefulWidget {
  const AbilitySearch({super.key});

  @override
  State<AbilitySearch> createState() => _AbilitySearchState();
}
void navigateToAbiliyDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => AbilityDetails(abilityName: name))
  );
}


class _AbilitySearchState extends State<AbilitySearch> {

  Ability? _ability;
  final TypeColor typeColor = TypeColor();
  List<Color> typeColors1 = [Colors.grey, Colors.grey.shade900];
  int error = 0;


  final TextEditingController _moveIdController = TextEditingController();
  final TextEditingController _moveNameController = TextEditingController();

  Future<void> _loadMoveDataByID(int moveId) async {
    final pokedex = Pokedex();
    late Ability? ability;
    try {
      ability = await pokedex.abilities.get(id: moveId);
      setState(() {
        _ability = ability;
      });
    } catch (e) {
      error = 1;
    }
  }

  Future<void> _loadMoveDataByName(String moveName) async {
    final pokedex = Pokedex();
    late Ability? ability;
    try {
      ability = await pokedex.abilities.get(name: moveName);
      setState(() {
        _ability = ability;
      });
    } catch (e) {
      error = 1;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _moveIdController.dispose();
    _moveNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Search for a Ability by ID or Name',
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
                  controller: _moveIdController,
                  decoration: const InputDecoration(
                    labelText: 'Search by ID',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  final String id = _moveIdController.text.trim();
                  if (id.isNotEmpty) {
                    final int moveId = int.tryParse(id) ?? 0;
                    _loadMoveDataByID(moveId);
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
                  controller: _moveNameController,
                  decoration: const InputDecoration(
                    labelText: 'Search by Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  final String name = _moveNameController.text.trim().toLowerCase().replaceAll(' ', '-');
                  if (name.isNotEmpty) {
                    _loadMoveDataByName(name);
                  }
                },
                child: const Text('Search'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (_ability != null)
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              onTap: () => navigateToAbiliyDetails(context, _ability!.name),
              title: Row(
                children: [
                  Text(
                    capitalize(_ability!.name),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              subtitle: Text('ID: #${_ability!.id.toString().padLeft(3, '0')}'),

            ),
          ),
      ],
    );
  }
}
