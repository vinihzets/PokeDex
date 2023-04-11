import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';
import 'package:pokedex/features/home/domain/usecases/fetch_all_pokemons_usecase.dart';

class FetchAllPokemonsUseCaseImp implements FetchAllPokemonsUseCase {
  HomeRepository homeRepository;

  FetchAllPokemonsUseCaseImp(this.homeRepository);

  Future<Either<Failure, dynamic>> fetchAllPokemons() {
    return homeRepository.fetchAllPokemons();
  }
}