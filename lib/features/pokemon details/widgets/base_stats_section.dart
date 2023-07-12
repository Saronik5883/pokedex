import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../utils/capitalize.dart';
import '../../ability/screens/ability_details.dart';

class BaseStatsSection extends StatefulWidget {
  final Pokemon pokemon;
  final PokemonSpecies pokemonSpecies;
  const BaseStatsSection({super.key, required this.pokemon, required this.pokemonSpecies});

  @override
  State<BaseStatsSection> createState() => _BaseStatsSectionState();
}

void navigatToAbilityDetails(BuildContext context, String name) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => AbilityDetails(abilityName: name))
  );
}


class _ChartData{
  _ChartData(this.x, this.y);

  final String x;
  final int y;
}

class _BaseStatsSectionState extends State<BaseStatsSection> {
  late List<_ChartData> data;
  late List<Color> colors;
  late TooltipBehavior _tooltip;

  
  @override
  void initState() {
    super.initState();
    data = [
      _ChartData('HP', widget.pokemon.stats[0].baseStat),
      _ChartData('ATK', widget.pokemon.stats[1].baseStat),
      _ChartData('DFS', widget.pokemon.stats[2].baseStat),
      _ChartData('SPL ATK', widget.pokemon.stats[3].baseStat),
      _ChartData('SPL DFS ', widget.pokemon.stats[4].baseStat),
      _ChartData('SP', widget.pokemon.stats[5].baseStat),
    ];

    colors = [
      Colors.redAccent,
      Colors.lightBlueAccent,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.purpleAccent,
      Colors.orangeAccent,
      Colors.pinkAccent,
    ];
    _tooltip = TooltipBehavior(enable: true);
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfCartesianChart(
            primaryXAxis: CategoryAxis(borderWidth: 0),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 140, interval: 20, isVisible: false),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              BarSeries<_ChartData, String>(
                pointColorMapper: (_ChartData data, _) => colors[data.x == 'HP' ? 0 : data.x == 'ATK' ? 1 : data.x == 'DFS' ? 2 : data.x == 'SPL ATK' ? 3 : data.x == 'SPL DFS' ? 4 : data.x == 'SP' ? 5 : 6],
                width: 0.5,
                borderRadius: BorderRadius.circular(10),
                dataSource: data,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                name: 'Base Stats',
              )
            ]
          ),
          const SizedBox(height: 10,),
          ListTile(
            title: const Text('Ability'),
            titleTextStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            subtitle: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: widget.pokemon.abilities.map((ability) => GestureDetector(
                onTap: () => navigatToAbilityDetails(context, ability.ability.name),
                child: Chip(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  label: Text(capitalize(ability.ability.name)),
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
              )).toList(),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('More info', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Habitat', style: TextStyle(color: Theme.of(context).colorScheme.outline),),
              ),
              const SizedBox(width: 43,),

               Text( widget.pokemonSpecies.habitat != null ? capitalize(widget.pokemonSpecies.habitat!.name) : '-' ),
            ],
          ),
          const SizedBox(height: 5,),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Shape', style: TextStyle(color: Theme.of(context).colorScheme.outline),),
              ),
              const SizedBox(width: 50,),

              Text(capitalize(widget.pokemonSpecies.shape.name)),
            ],
          ),
          const SizedBox(height: 5,),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Color', style: TextStyle(color: Theme.of(context).colorScheme.outline),),
              ),
              const SizedBox(width: 80,),

              Text(capitalize(widget.pokemonSpecies.color.name)),
            ],
          ),
          const SizedBox(height: 5,),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Capture rate', style: TextStyle(color: Theme.of(context).colorScheme.outline),),
              ),
              const SizedBox(width: 54,),

              Text(capitalize(widget.pokemonSpecies.captureRate.toString())),
            ],
          ),
          const SizedBox(height: 5,),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Base Happiness', style: TextStyle(color: Theme.of(context).colorScheme.outline),),
              ),
              const SizedBox(width: 30,),

              Text(capitalize(widget.pokemonSpecies.baseHappiness.toString())),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Base EXP', style: TextStyle(color: Theme.of(context).colorScheme.outline),),
              ),
              const SizedBox(width: 70,),

              Text(capitalize(widget.pokemon.baseExperience.toString())),
            ],
          ),
        ],
      ),
    );
  }
}
