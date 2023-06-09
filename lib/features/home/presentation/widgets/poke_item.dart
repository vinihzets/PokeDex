import 'package:flutter/material.dart';
import 'package:pokedex/core/utils/icons_type.dart';
import 'package:pokedex/core/utils/poke_color.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_entity.dart';
import 'package:pokedex/features/home/presentation/widgets/poke_infos.dart';

class PokeItem extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokeItem({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: PokeBoxColor.getColorPokemonType(
                  type: pokemon.types != null
                      ? pokemon.types![0].type!.name!
                      : '')),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PokemonInfo(
                      pokemon: pokemon,
                    ))),
            child: Column(
              children: [
                Text(
                  pokemon.name ?? '',
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
                                        child:
                                            Image.network(IconTypes.getIconType(
                                          type.type?.name ?? '',
                                        ))),
                                  ],
                                ))
                            .toList() ??
                        List.empty()),
                pokemon.sprites != null
                    ? Image.network(
                        pokemon.sprites!.frontDefault!,
                        width: 170.0,
                        height: 100.0,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ));
  }
}
