import 'package:flutter/material.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_entity.dart';
import 'package:pokedex/features/home/presentation/widgets/poke_infos.dart';

class PokeItemSearch extends StatelessWidget {
  final PokemonEntity pokemon;
  const PokeItemSearch({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: gPokemonRepository.getColorPokemonType(
                type: pokemon.types![0].type!.name!)),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PokemonInfo(
                    pokemon: pokemon,
                  ))),
          child: Column(
            children: [
              Text(
                pokemon.name!,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              Wrap(
                  children: pokemon.types
                          ?.map((type) => Wrap(
                                children: [
                                  SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: Image.network(
                                          gPokemonRepository.getIconType(
                                        type.type?.name ?? '',
                                      ))),
                                ],
                              ))
                          .toList() ??
                      List.empty()),
              Image.network(
                pokemon.sprites!.frontDefault!,
                width: 170.0,
                height: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
