import 'package:pokedex_riverpod/domain/entities/pokemon.dart';
import 'package:pokedex_riverpod/domain/repository/pokemon_repository.dart';

class GetPokemonDetail {
  final PokemonRepository repository;

  const GetPokemonDetail({required this.repository});

  Future<Pokemon> call(int id) => repository.getPokemon(id);
}
