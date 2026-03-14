import 'package:flutter/material.dart';
import 'package:pokedex_riverpod/screens/list_page.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: LogoSection(
          photo: 'assets/pokedex_logo.png',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.red,
                        padding: const .all(16),
                        alignment: .topLeft,
                        child: LogoSection(
                          photo: 'assets/pokedex_logo.png',
                          width: 200.0,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                      PokemonList(),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class LogoSection extends StatelessWidget {
  const LogoSection({
    super.key,
    required this.photo,
    this.onTap,
    required this.width,
  });

  final String photo;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(photo, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
