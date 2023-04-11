import 'package:either_dart/either.dart';
import 'package:pokedex/core/failure/failure.dart';
import 'package:pokedex/features/home/domain/repositories/home_repository.dart';
import 'package:pokedex/features/home/domain/usecases/fetch_all_pokemons_info_usecase.dart';

class FetchAllPokemonsInfoUseCaseImp implements FetchAllPokemonsInfoUseCase {
  HomeRepository homeRepository;

  FetchAllPokemonsInfoUseCaseImp(this.homeRepository);

  Future<Either<Failure, dynamic>> fetchAllPokemonsInfo(String url) {
    return homeRepository.fetchAllPokemonsInfo(url);
  }
}
