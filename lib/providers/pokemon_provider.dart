import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_riverpod/services/pokemon_service.dart';
import 'package:pokedex_riverpod/models/pokemon_model.dart';

final dioProvider = Provider((ref) => Dio());

final serviceProvider = Provider(
  (ref) => PokemonService(dio: ref.watch(dioProvider)),
);

final pokemonRepositoryProvider = Provider(
  (ref) => PokemonRepository(service: ref.watch(serviceProvider)),
);

final pokemonDetailProvider = FutureProvider.family<Pokemon, int>((
  ref,
  id,
) async {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.getPokemon(id);
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
