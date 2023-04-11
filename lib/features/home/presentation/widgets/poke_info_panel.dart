import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex/container/home_loading.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/repository/pokemon.dart';
import 'package:pokedex/repository/pokemonevos.dart';
import 'package:pokedex/widgets/poke_evolves.dart';
import 'package:pokedex/widgets/poke_stats_panel.dart';

class PokeInfoPanel extends StatelessWidget {
  final ScrollController controller;
  final Pokemon pokemon;
  const PokeInfoPanel(
      {required this.controller, required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 41, 39, 39),
          body: TabBarView(
            children: <Widget>[
              Tab(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SizedBox(
                          child: Text(
                        pokemon.name.toString(),
                        style: const TextStyle(
                            fontSize: 46.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )),
                    ),
                    ...?pokemon.types?.map(
                      (type) => SizedBox(
                          child: Text(
                        type.type?.name ?? '',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: gPokemonRepository.getColorPokemonType(
                                type: type.type!.name.toString())),
                      )),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 100.0, top: 30.0),
                                child: Text(
                                  pokemon.weight.toString(),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 120.0, top: 30.0),
                                child: Text(
                                  pokemon.height.toString(),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 95.0),
                                  child: Text(
                                    'Weight',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 82, 80, 80)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 100.0),
                                  child: Text(
                                    'Height',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 82, 80, 80)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PokeStatsPanel(
                            pokemon: pokemon,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PokemonEvolves(pokemon: pokemon)
            ],
          ),
        ),
      );
}
