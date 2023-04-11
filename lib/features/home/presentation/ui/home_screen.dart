import 'package:flutter/material.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/container/home_loading.dart';
import 'package:pokedex/features/home/domain/entities/pokemon.dart';
import 'package:pokedex/features/home/presentation/widgets/poke_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  bool showInputTextField = false;
  bool returned = false;
  bool onPressioned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned(
          top: -30,
          left: 60,
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              gConstsImages.blackpokeball,
              width: 360,
              height: 330,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70.0, left: 0.0),
          child: Row(
            children: [
              returned == true
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          nameController.text = '';

                          onPressioned = false;
                          returned = false;
                          showInputTextField = false;
                        });
                      },
                      icon: Icon(Icons.restore))
                  : Text(''),
              const Text(
                'Pokedex',
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              showInputTextField == true
                  ? Expanded(
                      child: TextField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      style: const TextStyle(fontSize: 12.0),
                      decoration: const InputDecoration(
                        hintText: 'Search your Pokemon',
                      ),
                    ))
                  : const SizedBox(
                      width: 5.0, height: 5.0, child: Text('hahaha')),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: IconButton(
                    onPressed: () async {
                      setState(() {
                        onPressioned = true;
                        showInputTextField = true;
                        returned = true;
                      });
                    },
                    icon: const Icon(Icons.search)),
              ),
            ],
          ),
        ),
        onPressioned == true && nameController.text.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 130.0),
                child: FutureBuilder(
                    future: gPokemonRepository
                        .getPokemonByName(nameController.text),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final url = '';
                        final pokemon =
                            PokemonEntity.fromJson(snapshot.data, url);
                        return GridView.builder(
                            itemCount: 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, pokeInfo) {
                              return PokeItem(pokemon: pokemon);
                            });
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const HomeLoading();
                      } else {
                        return const Center(
                            child: Text(
                          'Não foi possivel encontrar este pokemon',
                          style: TextStyle(fontSize: 20.0),
                        ));
                      }
                    })))
            : Padding(
                padding: const EdgeInsets.only(top: 130.0),
                child: FutureBuilder(
                    future: gPokemonRepository.getPokemonsFetch(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const HomeLoading();
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(12),
                          addAutomaticKeepAlives: true,
                          itemCount: 700,
                          itemBuilder: (context, index) {
                            final url = snapshot.data['results'][index]['url'];

                            return FutureBuilder(
                              future:
                                  gPokemonRepository.getInfoPokemonsFetch(url),
                              builder: (context, pokemonInfo) {
                                if (pokemonInfo.hasData) {
                                  final pokemon = PokemonEntity.fromJson(
                                      pokemonInfo.data, url);
                                  return PokeItem(
                                    pokemon: pokemon,
                                  );
                                } else {
                                  return const HomeLoading();
                                }
                              },
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                        );
                      }
                      return const HomeLoading();
                    })))
      ],
    ));
  }
}
