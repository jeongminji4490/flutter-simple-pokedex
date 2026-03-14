import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FrontCard extends StatefulWidget {
  const FrontCard({super.key, required this.image, required this.number});

  final String image;
  final String number;

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
                  widget.number.toString(),
                  style: TextStyle(
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
              color: Colors.white,
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const SizedBox(height: 10),
                  Flexible(child: SvgPicture.network(widget.image, width: 200)),
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
