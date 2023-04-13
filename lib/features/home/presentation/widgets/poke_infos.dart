import 'package:flutter/material.dart';
import 'package:pokedex/core/utils/poke_color.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_entity.dart';
import 'package:pokedex/features/home/presentation/widgets/poke_info_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonInfo extends StatefulWidget {
  final PokemonEntity pokemon;

  const PokemonInfo({
    required this.pokemon,
    super.key,
  });

  @override
  State<PokemonInfo> createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<PokemonInfo> {
  @override
  Widget build(BuildContext context) {
    final getColor = PokeBoxColor.getColorPokemonType(
        type: widget.pokemon.types!.first.type!.name.toString());

    return Scaffold(
      backgroundColor: getColor,
      body: SlidingUpPanel(
        maxHeight: 410,
        color: const Color.fromARGB(255, 20, 20, 20),
        panelBuilder: (controller) => PokeInfoPanel(
          pokemon: widget.pokemon,
          controller: controller,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 11.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.subdirectory_arrow_left,
                        color: Colors.white,
                      )),
                  const Text(
                    'Pokedex',
                    style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 160.0),
                    child: Text(
                      '#0${widget.pokemon.id}',
                      style: const TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Image.network(
              widget.pokemon.sprites!.frontDefault.toString(),
              width: 250.0,
              height: 250.0,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
