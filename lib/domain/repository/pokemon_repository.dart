import 'package:pokedex_riverpod/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<Pokemon> getPokemon(int id);
}
