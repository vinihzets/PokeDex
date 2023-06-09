import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';
import 'package:pokedex/features/home/domain/entities/fetch_pokes_entity.dart';
import 'package:pokedex/features/home/domain/repositories/home_repository.dart';
import 'package:pokedex/features/home/domain/usecases/fetch_all_pokemons_usecase.dart';

class FetchAllPokemonsUseCaseImp implements FetchAllPokemonsUseCase {
  HomeRepository homeRepository;

  FetchAllPokemonsUseCaseImp(this.homeRepository);

  @override
  Future<Either<Failure, List<FetchPokesEntity>>> fetchAllPokemons() {
    return homeRepository.fetchAllPokemons();
  }
}
