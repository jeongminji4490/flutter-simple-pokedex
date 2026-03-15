import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_riverpod/providers/pokemon_provider.dart';

class PokemonSearchBar extends ConsumerStatefulWidget {
  const PokemonSearchBar({super.key});

  @override
  ConsumerState<PokemonSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<PokemonSearchBar> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: .circular(8),
              border: .all(color: Colors.black, width: 5),
            ),
            child: TextFormField(
              style: GoogleFonts.aBeeZee(
                fontSize: 15,
                fontWeight: .normal,
                color: Colors.black,
                decoration: .none,
              ),
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Search Pokemon',
                border: .none,
                contentPadding: .symmetric(horizontal: 12, vertical: 8),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Pokemon name';
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => ref
              .read(pokemonNotifier.notifier)
              .searchPokemon(textController.text.trim()),
          child: Image.asset('assets/pokeball.png', width: 40, height: 40),
        ),
      ],
    );
  }
}
