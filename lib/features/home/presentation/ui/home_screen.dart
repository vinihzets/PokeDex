import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/architeture/bloc_builder.dart';
import 'package:pokedex/architeture/bloc_state.dart';
import 'package:pokedex/core/utils/consts.dart';
import 'package:pokedex/features/home/data/datasources/home_datasources.dart';
import 'package:pokedex/features/home/data/dtos/fetch_pokes_dto.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_entity.dart';
import 'package:pokedex/features/home/presentation/bloc/home_bloc.dart';
import 'package:pokedex/features/home/presentation/bloc/home_event.dart';
import 'package:pokedex/features/home/presentation/widgets/poke_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pokemonController = TextEditingController();
  bool showInputTextField = false;
  bool returned = false;
  bool onSearch = false;

  late HomeBloc bloc;
  late ConstsImages constsImages;
  late HomeDataSources homeDataSources;

  @override
  void initState() {
    bloc = GetIt.I.get();
    constsImages = GetIt.I.get();
    homeDataSources = GetIt.I.get();

    bloc.event.add(HomeEventFetchAllPokemons(context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -30,
            left: 60,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                constsImages.blackpokeball,
                width: 360,
                height: 330,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              children: [
                showInputTextField == false
                    ? IconButton(
                        onPressed: () {
                          showInputTextField = true;

                          setState(() {});
                        },
                        icon: const Icon(Icons.search))
                    : IconButton(
                        onPressed: () {
                          showInputTextField = false;
                          bloc.event.add(HomeEventFetchAllPokemons(context));

                          onSearch = false;

                          setState(() {});
                        },
                        icon: const Icon(Icons.rotate_left)),
                if (showInputTextField == true)
                  Row(
                    children: [
                      SizedBox(
                        width: 270,
                        child: TextField(
                          controller: pokemonController,
                          decoration: const InputDecoration(
                              hintText: 'Pesquise por seu pokemon',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            onSearch = true;

                            setState(() {});
                          },
                          icon: const Icon(Icons.send))
                    ],
                  )
                else
                  const SizedBox.shrink()
              ],
            ),
          ),
          onSearch == false
              ? Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: BlocScreenBuilder(
                      stream: bloc.statePokemons,
                      builder: (state) {
                        if (state is BlocStableState) {
                          final List<FetchPokesDto> list = state.data;
                          return GridView(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            children: list.map((e) {
                              return _buildPokemonItem(homeDataSources, e);
                            }).toList(),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                )
              : _buildGetPokemonByName(homeDataSources, pokemonController.text)
        ],
      ),
    ));
  }
}

Widget _buildPokemonItem(HomeDataSources homeDataSources, e) {
  return FutureBuilder(
      future: homeDataSources.fetchPokemonInfo(e.url),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pokemon = snapshot.data!.fold((left) => null, (right) => right);

          if (pokemon != null) {
            return PokeItem(pokemon: pokemon);
          }
        }
        return const SizedBox.shrink();
      });
}

_buildGetPokemonByName(HomeDataSources homeDataSources, String name) {
  return FutureBuilder(
      future: homeDataSources.getPokemonByName(name),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pokemon = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.only(top: 140.0, bottom: 360),
            child: PokeItem(pokemon: pokemon),
          );
        } else {
          return const Center(
            child: Text('Nenhum Pokemon com esse nome encontrado'),
          );
        }
      });
}

// Padding(
//                   padding: const EdgeInsets.only(top: 70.0, left: 0.0),
//                   child: Row(
//                     children: [
//                       returned == true
//                           ? IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   nameController.text = '';

//                                   onPressioned = false;
//                                   returned = false;
//                                   showInputTextField = false;
//                                 });
//                               },
//                               icon: const Icon(Icons.restore))
//                           : const Text(''),
//                       const Text(
//                         'Pokedex',
//                         style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
//                       ),
//                       showInputTextField == true
//                           ? Expanded(
//                               child: TextField(
//                               keyboardType: TextInputType.name,
//                               controller: nameController,
//                               style: const TextStyle(fontSize: 12.0),
//                               decoration: const InputDecoration(
//                                 hintText: 'Search your Pokemon',
//                               ),
//                             ))
//                           : const SizedBox(
//                               width: 5.0, height: 5.0, child: Text('hahaha')),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 50.0),
//                         child: IconButton(
//                             onPressed: () async {
//                               setState(() {
//                                 onPressioned = true;
//                                 showInputTextField = true;
//                                 returned = true;
//                               });
//                             },
//                             icon: const Icon(Icons.search)),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onPressioned == true && nameController.text.isNotEmpty
//                     ? Padding(
//                         padding: const EdgeInsets.only(top: 130.0),
//                         child: FutureBuilder(
//                             future: gPokemonRepository
//                                 .getPokemonByName(nameController.text),
//                             builder: ((context, snapshot) {
//                               if (snapshot.hasData) {
                               
//                                 final pokemon =
//                                     PokemonEntity.fromJson(snapshot.data);
//                                 return GridView.builder(
//                                     itemCount: 1,
//                                     gridDelegate:
//                                         const SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 2),
//                                     itemBuilder: (context, pokeInfo) {
//                                       return PokeItem(pokemon: pokemon);
//                                     });
//                               } else if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const HomeLoading();
//                               } else {
//                                 return const Center(
//                                     child: Text(
//                                   'Não foi possivel encontrar este pokemon',
//                                   style: TextStyle(fontSize: 20.0),
//                                 ));
//                               }
//                             })))
//                     : Padding(
//                         padding: const EdgeInsets.only(top: 130.0),
//                         child: FutureBuilder(
//                             future: gPokemonRepository.getPokemonsFetch(),
//                             builder: ((context, snapshot) {
//                               if (snapshot.connectionState == ConnectionState.waiting) {
//                                 return const HomeLoading();
//                               } else if (snapshot.hasData) {
//                                 return GridView.builder(
//                                   physics: const BouncingScrollPhysics(),
//                                   padding: const EdgeInsets.all(12),
//                                   addAutomaticKeepAlives: true,
//                                   itemCount: 700,
//                                   itemBuilder: (context, index) {
//                                     final url = snapshot.data['results'][index]['url'];

//                                     return FutureBuilder(
//                                       future:
//                                           gPokemonRepository.getInfoPokemonsFetch(url),
//                                       builder: (context, pokemonInfo) {
//                                         if (pokemonInfo.hasData) {
//                                           final pokemon = PokemonEntity.fromJson(
//                                               pokemonInfo.data);
//                                           return PokeItem(
//                                             pokemon: pokemon,
//                                           );
//                                         } else {
//                                           return const HomeLoading();
//                                         }
//                                       },
//                                     );
//                                   },
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount: 2),
//                                 );
//                               }
//                               return const HomeLoading();
//                             })))
