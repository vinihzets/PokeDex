import 'package:flutter/material.dart';

class PokeBoxColor {
  static Color? getColorPokemonType({required String type}) {
    switch (type) {
      case 'normal':
        return Colors.brown[200];
      case 'fightning':
        return Colors.brown[50];
      case 'poison':
        return Colors.pink[200];
      case 'ground':
        return Colors.brown;
      case 'rock':
        return const Color.fromARGB(255, 29, 29, 29);
      case 'bug':
        return Colors.greenAccent[100];
      case 'ghost':
        return const Color.fromARGB(255, 67, 3, 119);
      case 'steel':
        return Colors.brown[50];
      case 'fire':
        return Colors.red[300];
      case 'water':
        return Colors.blue[300];
      case 'grass':
        return Colors.green[200];
      case 'electric':
        return Colors.yellow[200];
      case 'psychic':
        return Colors.amber[200];
      case 'ice':
        return Colors.lightBlue[200];
      case 'dragon':
        return Colors.grey[300];
      case 'dark':
        return const Color.fromARGB(255, 49, 2, 104);
      case 'fairy':
        return Colors.pink[100];
      case 'unknow':
        return const Color.fromARGB(255, 49, 2, 104);
      case 'shadow':
        return Colors.black;
    }
    return null;
  }
}
