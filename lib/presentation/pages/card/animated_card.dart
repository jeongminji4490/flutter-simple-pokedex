import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'dart:math';
import 'package:pokedex_riverpod/presentation/pages/card/back_card.dart';
import 'package:pokedex_riverpod/presentation/pages/card/front_card.dart';

// Manage the front/back status of each card by index
final isFrontProvider = StateProvider.family<bool, int>((ref, index) => true);

class AnimatedCard extends ConsumerStatefulWidget {
  final int index;
  final String pokemonName;
  final String pokemonImage;

  const AnimatedCard({
    super.key,
    required this.index,
    required this.pokemonName,
    required this.pokemonImage,
  });

  @override
  ConsumerState<AnimatedCard> createState() => _AnimatedCard();
}

class _AnimatedCard extends ConsumerState<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _flipCard() {
    final isFront = ref.read(isFrontProvider(widget.index));
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    ref.read(isFrontProvider(widget.index).notifier).state = !isFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final isBack = angle > pi / 2;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: BackCard(name: widget.pokemonName),
                  )
                : FrontCard(
                    image: widget.pokemonImage,
                    number: widget.index.toString(),
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
