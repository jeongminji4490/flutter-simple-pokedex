import 'package:pokedex_riverpod/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex_riverpod/domain/entities/pokemon.dart';
import 'package:pokedex_riverpod/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDatasource datasource;

  const PokemonRepositoryImpl({required this.datasource});

  @override
  Future<Pokemon> getPokemon(int id) async {
    final response = await datasource.getPokemonImage(id);
    return Pokemon(
      name: response.form.name,
      image: response.sprites.other.dreamWorld.frontDefault,
    );
  }
}
