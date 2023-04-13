import 'package:flutter/material.dart';
import 'package:pokedex/core/utils/poke_color.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_entity.dart';
import 'package:pokedex/features/home/presentation/widgets/poke_stats_panel.dart';

class PokeInfoPanel extends StatelessWidget {
  final ScrollController controller;
  final PokemonEntity pokemon;
  const PokeInfoPanel(
      {required this.controller, required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 41, 39, 39),
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
                            color: PokeBoxColor.getColorPokemonType(
                                type: type.type!.name.toString())),
                      )),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                pokemon.weight.toString(),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                pokemon.height.toString(),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  'Weight',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 82, 80, 80)),
                                ),
                                Text(
                                  'Height',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 82, 80, 80)),
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
              // PokemonEvolves(pokemon: pokemon)
            ],
          ),
        ),
      );
}
