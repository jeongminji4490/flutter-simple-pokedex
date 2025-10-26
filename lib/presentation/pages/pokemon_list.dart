import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_riverpod/presentation/pages/card/animated_card.dart';
import 'package:pokedex_riverpod/presentation/providers/pokemon_provider.dart';

class PokemonList extends ConsumerStatefulWidget {
  const PokemonList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PokemonList();
}

class _PokemonList extends ConsumerState<PokemonList> {
  final _scrollController = ScrollController();
  var itemCount = 20;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        final newCount = itemCount + 20;
        await ref.read(pokemonListProvider(newCount).future);
        if (mounted) {
          setState(() {
            itemCount = newCount;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncPokemon = ref.watch(pokemonListProvider(itemCount));

    return Expanded(
      child: Container(
        color: Colors.red,
        child: asyncPokemon.when(
          data: (pokemon) => GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: pokemon.length,
            itemBuilder: (context, index) {
              final pokemonName = pokemon[index].name;
              final pokemonImage = pokemon[index].image;
              return AnimatedCard(
                index: index,
                pokemonName: pokemonName,
                pokemonImage: pokemonImage,
              );
            },
          ),
          error: (e, _) => Center(
            child: Text(
              'Error: $e',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
