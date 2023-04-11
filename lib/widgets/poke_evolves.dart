import 'package:flutter/material.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/repository/pokemon.dart';
import 'package:pokedex/repository/pokemonevos.dart';

class PokemonEvolves extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonEvolves({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: gPokemonRepository.getPokeEvolutions(),
        builder: ((context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            final realList =
                snapshot.data?.map((e) => PokemonEvos.fromJson(e)).toList() ??
                    [];
            final selectedPokemon = realList.firstWhere(
              (element) => element.id == pokemon.id,
            );

            return Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Column(
                    children: selectedPokemon.prevEvolution
                            ?.map((e) => Text(
                                  'Evolução Anterior ${e.name ?? 'Não Possui Evolução Anterior'}',
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ))
                            .toList() ??
                        [],
                  ),
                ),
                Column(
                    children: [Image.network(selectedPokemon.img.toString())]),
                Column(
                  children: selectedPokemon.nextEvolution
                          ?.map((e) => Text(
                                'Proxima Evolução ${e.name ?? 'Não Possui Proxima Evolução'}',
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ))
                          .toList() ??
                      [],
                ),
              ]),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
