import 'package:flutter/material.dart';

class BackCard extends StatefulWidget {
  const BackCard({super.key, required this.name});

  final String name;

  @override
  State<StatefulWidget> createState() => _BackCard();
}

class _BackCard extends State<BackCard> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: .all(10),
    child: Image.asset('assets/pokedex_card.png', fit: BoxFit.fill),
  );
}
