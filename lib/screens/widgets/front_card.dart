import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrontCard extends StatefulWidget {
  const FrontCard({super.key, required this.image, required this.name});

  final String image;
  final String name;

  @override
  State<StatefulWidget> createState() => _FrontCard();
}

class _FrontCard extends State<FrontCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .all(10),
      decoration: BoxDecoration(
        border: .all(color: Color(0xFF0C1670), width: 15),
        borderRadius: .circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Color(0xFF0C1670),
              child: Center(
                child: Text(
                  widget.name.toUpperCase(),
                  style: GoogleFonts.bitcountPropDouble(
                    fontSize: 30,
                    fontWeight: .bold,
                    color: Colors.white,
                    decoration: .none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: .infinity,
              color: Color(0xFF0C1670),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const SizedBox(height: 10),
                  Flexible(child: Image.network(widget.image)),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
