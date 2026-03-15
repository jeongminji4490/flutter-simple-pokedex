import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PokemonSkeleton extends StatelessWidget {
  const PokemonSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFF0C1670),
      highlightColor: Color.fromARGB(255, 32, 42, 127),
      child: Container(
        margin: const .all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: .circular(10),
        ),
      ),
    );
  }
}
