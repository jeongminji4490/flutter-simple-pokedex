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
    Future.delayed(Duration(milliseconds: 500), () {
      ref.read(pokemonNotifier.notifier).loadPokemons(itemCount);
    });

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        final newCount = itemCount + 20;
        await ref.read(pokemonNotifier.notifier).loadPokemons(newCount);
        if (mounted) {
          setState(() {
            itemCount = newCount;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final asyncPokemon = ref.watch(pokemonNotifier);
    asyncPokemon;
    return Expanded(
      child: Container(
        color: Colors.red,
        child: asyncPokemon.when(
          data: (state) => GridView.builder(
            controller: _scrollController,
            padding: .all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: state.pokemonList?.length ?? 0,
            itemBuilder: (context, index) {
              final name = state.pokemonList?[index].name ?? '';
              final image = state.pokemonList?[index].image ?? '';
              final types = state.pokemonList?[index].types ?? '';
              final abilities = state.pokemonList?[index].abilities ?? '';
              return AnimatedCard(
                index: index,
                name: name,
                image: image,
                types: types,
                abilities: abilities,
              );
            },
          ),
          error: (e, _) => Center(child: NoResultWidget()),
          loading: () => GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemCount: 20,
            itemBuilder: (context, index) => const PokemonSkeleton(),
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

class NoResultWidget extends StatelessWidget {
  const NoResultWidget({super.key});

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
