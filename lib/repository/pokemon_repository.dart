import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/repository/pokemon.dart';
import 'package:pokedex/repository/pokemonevos.dart';

class PokemonRepository {
  Future getPokemonsFetch() async {
    String api = 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=700';

    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return throw Exception('Erro ao carregar A API');
    }
  }

  Future<List> getPokeEvolutions() async {
    String api =
        'https://raw.githubusercontent.com/Biuni/PokemonGo-pokedex/master/pokedex.json';
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final list = decoded['pokemon'];
      return list as List;
    } else {
      return throw Exception('Não foi possivel carregar essa api');
    }
  }

  Future getPokemonByName(String name) async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return throw Exception('Não foi possivel fazer isso');
    }
  }

  Future getInfoPokemonsFetch(String api) async {
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return throw Exception('Erro ao carregar A API');
    }
  }

  getIconType(
    String type,
  ) {
    switch (type) {
      case 'poison':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/poison.png';
      case 'normal':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/normal.png';
      case 'fighting':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/fighting.png';
      case 'ground':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/ground.png';
      case 'rock':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/rock.png';
      case 'bug':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/bug.png';
      case 'ghost':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/ghost.png';
      case 'steel':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/steel.png';
      case 'fire':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/fire.png';
      case 'water':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/water.png';
      case 'grass':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/grass.png';
      case 'electric':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/electric.png';
      case 'psychic':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/psychic.png';
      case 'ice':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/ice.png';
      case 'dragon':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/dragon.png';
      case 'dark':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/dark.png';
      case 'fairy':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/fairy.png';
      case 'unknow':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/poison.png';
      case 'flying':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/flying.png';
      case 'shadow':
        return 'https://vortigo.blob.core.windows.net/files/pokemon/assets/shadow.png';
    }
  }

  Color? getColorPokemonType({required String type}) {
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
  }
}
