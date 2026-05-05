import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_riverpod/screens/widgets/animated_card.dart';
import 'package:pokedex_riverpod/providers/pokemon_provider.dart';
import 'package:pokedex_riverpod/screens/widgets/shimmer.dart';

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
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        final asyncState = ref.read(pokemonNotifier);
        if (asyncState.isLoading) return;
        if (asyncState.value?.nextUrl == null) return;
        await ref.read(pokemonNotifier.notifier).loadPokemons();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final asyncPokemon = ref.watch(pokemonNotifier);
    return Expanded(
      child: Container(
        color: Colors.red,
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 5;
            } else if (constraints.maxWidth > 800) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 500) {
              crossAxisCount = 3;
            }

            final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            );

            return asyncPokemon.when(
              data: (state) => GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(12),
                gridDelegate: gridDelegate,
                itemCount: state.pokemonList?.length ?? 0,
                itemBuilder: (context, index) {
                  final pokemon = state.pokemonList![index];
                  return AnimatedCard(
                    index: index,
                    name: pokemon.name,
                    image: pokemon.image,
                    types: pokemon.types,
                    abilities: pokemon.abilities,
                  );
                },
              ),
              loading: () => GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: gridDelegate,
                itemCount: 20,
                itemBuilder: (context, index) => const PokemonSkeleton(),
              ),
              error: (e, _) => Center(child: _NoResultWidget()),
            );
          },
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

class _NoResultWidget extends StatelessWidget {
  const _NoResultWidget();

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: .center,
    children: [
      const SizedBox(height: 20),
      Image.asset('assets/snorlax.gif', width: 200, height: 200),
      const SizedBox(height: 20),
      Text(
        'No results found',
        style: GoogleFonts.bitcountPropDouble(
          fontSize: 50,
          fontWeight: .normal,
          color: Colors.black,
          decoration: .none,
        ),
      ),
    ],
  );
}
