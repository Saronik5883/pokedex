import 'package:flutter/material.dart';
class TypeColor {
  Future<Color> typeColor(String type) async {
    switch (type) {
      case 'normal':
        return const Color(0xFFA8A878);
      case 'fire':
        //return const Color(0xFFF08030);
        return Colors.deepOrangeAccent;
      case 'water':
        return const Color(0xFF6890F0);
      case 'electric':
        return const Color(0xFFF8D030);
      case 'grass':
        return Colors.lightGreenAccent;
      case 'ice':
        return const Color(0xFF98D8D8);
      case 'fighting':
        return const Color(0xFFC03028);
      case 'poison':
        return Colors.deepPurpleAccent;
      case 'ground':
        return const Color(0xFFE0C068);
      case 'flying':
        return const Color(0xFFA890F0);
      case 'psychic':
        return const Color(0xFFF85888);
      case 'bug':
        return const Color(0xFFA8B820);
      case 'rock':
        return const Color(0xFFB8A038);
      case 'ghost':
        return const Color(0xFF705898);
      case 'dragon':
        return const Color(0xFF7038F8);
      case 'dark':
        return const Color(0xFF705848);
      case 'steel':
        return const Color(0xFFB8B8D0);
      case 'fairy':
        return const Color(0xFFEE99AC);
      default:
        return const Color(0xFFA8A878);
    }
  }

  Future<Color> textColor(String type) async {
    switch (type) {
      case 'normal':
        return const Color(0xFF3A3A2B);
      case 'fire':
        return const Color(0xFF673615);
      case 'water':
        return const Color(0xFF142850);
      case 'electric':
        return const Color(0xFF6E5713);
      case 'grass':
        return const Color(0xFF274E13);
      case 'ice':
        return const Color(0xFF295050);
      case 'fighting':
        return const Color(0xFF4D100C);
      case 'poison':
        return const Color(0xFF3A0A3A);
      case 'ground':
        return const Color(0xFF483B23);
      case 'flying':
        return const Color(0xFF544672);
      case 'psychic':
        return const Color(0xFF3A0A3A);
      case 'bug':
        return const Color(0xFF48500F);
      case 'rock':
        return const Color(0xFF3A2E14);
      case 'ghost':
        return const Color(0xFF3A0A3A);
      case 'dragon':
        return const Color(0xFF3A0A3A);
      case 'dark':
        return const Color(0xFF3A2920);
      case 'steel':
        return const Color(0xFF434359);
      case 'fairy':
        return const Color(0xFF3A0A3A);
      default:
        return const Color(0xFF000000);
    }
  }
}