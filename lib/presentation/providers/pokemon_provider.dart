import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_riverpod/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex_riverpod/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex_riverpod/domain/entities/pokemon.dart';
import 'package:pokedex_riverpod/domain/usecases/get_pokemon_detail.dart';

final dioProvider = Provider((ref) => Dio());

final remoteDataSourceProvider = Provider(
  (ref) => PokemonRemoteDatasource(dio: ref.watch(dioProvider)),
);

final pokemonRepositoryProvider = Provider(
  (ref) =>
      PokemonRepositoryImpl(datasource: ref.watch(remoteDataSourceProvider)),
);

final getPokemonDetailProvider = Provider(
  (ref) => GetPokemonDetail(repository: ref.watch(pokemonRepositoryProvider)),
);

final pokemonDetailFutureProvider = FutureProvider.family<Pokemon, int>((
  ref,
  id,
) async {
  final getPokemonDetail = ref.watch(getPokemonDetailProvider);
  return getPokemonDetail(id);
});

final pokemonListProvider = FutureProvider.family<List<Pokemon>, int>((
  ref,
  count,
) async {
  final repo = ref.watch(pokemonRepositoryProvider);

  final results = await Future.wait(
    List.generate(count, (i) => repo.getPokemon(i + 1)),
  );

  return results;
});
