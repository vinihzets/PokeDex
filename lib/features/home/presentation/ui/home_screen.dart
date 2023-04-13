import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/architeture/bloc_builder.dart';
import 'package:pokedex/architeture/bloc_state.dart';
import 'package:pokedex/core/utils/consts.dart';
import 'package:pokedex/features/home/data/datasources/home_datasources.dart';
import 'package:pokedex/features/home/data/dtos/fetch_pokes_dto.dart';
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
