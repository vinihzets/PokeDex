import 'package:flutter/material.dart';
import 'package:pokedex/features/home/domain/entities/pokemon.dart';

class PokeStatsPanel extends StatelessWidget {
  final PokemonEntity pokemon;
  const PokeStatsPanel({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    return _buildStatsColumn(context);
  }

  Widget _buildStatsColumn(BuildContext context) {
    final stats = pokemon.stats!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Estatísticas Básicas",
          ),
          _buildStatRow(context, "HP", stats[0].baseStat!, 255, Colors.red),
          _buildStatRow(context, "ATK", stats[1].baseStat!, 190, Colors.blue),
          _buildStatRow(context, "DEF", stats[2].baseStat!, 230, Colors.orange),
          _buildStatRow(context, "SA", stats[3].baseStat!, 194, Colors.pink),
          _buildStatRow(context, "SD", stats[4].baseStat!, 230, Colors.green),
          _buildStatRow(context, "SPD", stats[5].baseStat!, 180, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildStatRow(
      BuildContext context, String name, int value, int max, Color color) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 40.0,
            child: Text(name),
          ),
          const SizedBox(width: 15.0),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: 20.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    width: value * (size.width - 66) / max,
                    height: 20.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: color,
                    ),
                    child: Text(value.toString() + "/" + max.toString(),
                        style: const TextStyle(color: Colors.white))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
