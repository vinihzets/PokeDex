import 'package:pokedex/features/home/domain/entities/fetch_pokes_entity.dart';

class FetchPokesDto extends FetchPokesEntity {
  FetchPokesDto(super.name, super.url);

  factory FetchPokesDto.fromJson(Map map) {
    return FetchPokesDto(map['name'], map['url']);
  }
}
