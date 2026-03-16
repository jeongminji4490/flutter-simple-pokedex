import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_riverpod/screens/list_page.dart';
import 'package:pokedex_riverpod/screens/widgets/search_bar.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: _LogoSection(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) {
              return Scaffold(
                backgroundColor: Colors.red,
                body: Column(
                  children: [
                    _LogoSection(onTap: () => Navigator.of(context).pop()),
                    Padding(padding: const .all(16), child: PokemonSearchBar()),
                    PokemonList(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LogoSection extends StatelessWidget {
  const _LogoSection({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'pokedex_logo',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Text(
              'POKEDEX',
              style: GoogleFonts.bitcountPropDouble(
                fontSize: 70,
                fontWeight: .bold,
                color: Colors.white,
                decoration: .none,
              ),
              textAlign: .center,
            ),
          ),
        ),
      ),
    );
  }
}
