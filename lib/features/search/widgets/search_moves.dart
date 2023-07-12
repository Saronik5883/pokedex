import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';

import '../../../utils/capitalize.dart';
import '../../../utils/type_color.dart';
import '../../moves/screens/move_details.dart';

class MoveSearch extends StatefulWidget {
  const MoveSearch({super.key});

  @override
  State<MoveSearch> createState() => _MoveSearchState();
}
void navigateToMoveDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => MoveDetails(moveName: name))
  );
}


class _MoveSearchState extends State<MoveSearch> {

  Move? moveResponse;
  final TypeColor typeColor = TypeColor();
  List<Color> typeColors1 = [Colors.grey, Colors.grey.shade900];
  int error = 0;


  final TextEditingController _moveIdController = TextEditingController();
  final TextEditingController _moveNameController = TextEditingController();

  Future<void> _loadMoveDataByID(int moveId) async {
    final pokedex = Pokedex();
    late Move? moveRes;
    try {
      moveRes = await pokedex.moves.get(id: moveId);
      final color1 = await typeColor.typeColor(moveRes.type.name);
      final color2 = await typeColor.textColor(moveRes.type.name);

      setState(() {
        moveResponse = moveRes;
        typeColors1 = [color1, color2];
      });
    } catch (e) {
      error = 1;
    }
  }

  Future<void> _loadMoveDataByName(String moveName) async {
    final pokedex = Pokedex();
    late Move? moveRes;
    try {
      moveRes = await pokedex.moves.get(name: moveName);
      final color1 = await typeColor.typeColor(moveRes.type.name);
      final color2 = await typeColor.textColor(moveRes.type.name);

      setState(() {
        moveResponse = moveRes;
        typeColors1 = [color1, color2];
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
            'Search for a Move by ID or Name',
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
        if (moveResponse != null)
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              onTap: () => navigateToMoveDetails(context, moveResponse!.name),
              title: Row(
                children: [
                  Text(
                    capitalize(moveResponse!.name),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 25,
                        width: 60,
                        decoration: BoxDecoration(
                          color: typeColors1[0],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                capitalize(moveResponse!.type.name),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: typeColors1[1],
                                )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              subtitle: Text('ID: #${moveResponse!.id.toString().padLeft(3, '0')}'),

            ),
          ),
      ],
    );
  }
}
