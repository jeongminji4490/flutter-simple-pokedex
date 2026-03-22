import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_riverpod/services/pokemon_service.dart';
import 'package:pokedex_riverpod/models/pokemon_model.dart';

class PokemonState {
  final List<Pokemon>? pokemonList;
  final String? nextUrl; // for pagination

  const PokemonState({this.pokemonList, this.nextUrl});
}

final pokemonNotifier =
    AsyncNotifierProvider.autoDispose<PokemonNotifier, PokemonState>(
      () => PokemonNotifier(),
    );

class PokemonNotifier extends AsyncNotifier<PokemonState> {
  @override
  Future<PokemonState> build() async {
    // Added delay to show the list after logo animation
    await Future.delayed(const Duration(seconds: 1));
    final response = await ref.read(serviceProvider).getPokemons();
    final pokemonList = await Future.wait(
      response.results.map((result) {
        return ref
            .read(pokemonRepositoryProvider)
            .getPokemonDetail(result.name);
      }),
    );
    return PokemonState(pokemonList: pokemonList, nextUrl: response.next);
  }

  Future<void> loadPokemons() async {
    final currentState = state.value;

    state = await AsyncValue.guard(() async {
      final response = await ref
          .read(serviceProvider)
          .getPokemons(url: currentState?.nextUrl);

      final newList = await Future.wait(
        response.results.map(
          (result) =>
              ref.read(pokemonRepositoryProvider).getPokemonDetail(result.name),
        ),
      );

      return PokemonState(
        pokemonList: [...(currentState?.pokemonList ?? []), ...newList],
        nextUrl: response.next,
      );
    });
  }

  Future<void> searchPokemon(String name) async {
    if (name.isEmpty) {
      state = const AsyncValue.loading();
      loadPokemons();
      return;
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final pokemon = await ref
          .read(pokemonRepositoryProvider)
          .getPokemonDetail(name);
      return PokemonState(pokemonList: [pokemon]);
    });
  }
}
