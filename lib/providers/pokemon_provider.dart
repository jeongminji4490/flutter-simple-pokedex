import 'dart:async';

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

class PokemonState {
  final List<Pokemon>? pokemonList;

  const PokemonState({this.pokemonList});
}

final pokemonNotifier =
    AsyncNotifierProvider.autoDispose<PokemonNotifier, PokemonState>(
      () => PokemonNotifier(),
    );

class PokemonNotifier extends AsyncNotifier<PokemonState> {
  @override
  Future<PokemonState> build() async {
    final result = await Future.wait(
      List.generate(
        20,
        (i) => ref.read(pokemonRepositoryProvider).getPokemon(id: i + 1),
      ),
    );
    return PokemonState(pokemonList: result);
  }

  Future<void> searchPokemon(String name) async {
    if (name.isEmpty) {
      loadPokemons(20);
      return;
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final pokemon = await ref
          .read(pokemonRepositoryProvider)
          .getPokemon(name: name);
      return PokemonState(pokemonList: [pokemon]);
    });
  }

  Future<void> loadPokemons(int count) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final list = await Future.wait(
        List.generate(
          count,
          (i) => ref.read(pokemonRepositoryProvider).getPokemon(id: i + 1),
        ),
      );
      return PokemonState(pokemonList: list);
    });
  }
}
