import 'package:flutter/material.dart';

class BackCard extends StatefulWidget {
  const BackCard({super.key, required this.name});

  final String name;

  @override
  State<StatefulWidget> createState() => _BackCard();
}

class _BackCard extends State<BackCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF0C1670),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          widget.name.toUpperCase(),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
