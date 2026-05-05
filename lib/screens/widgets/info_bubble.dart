import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonInfoBubble extends StatefulWidget {
  final Widget child;
  final List<String> messages;

  const PokemonInfoBubble({
    super.key,
    required this.child,
    required this.messages,
  });

  @override
  State<PokemonInfoBubble> createState() => _PokemonInfoBubbleState();
}

class _PokemonInfoBubbleState extends State<PokemonInfoBubble> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Timer? _timer;

  void _showBubble() {
    _overlayEntry = _createOverlayEntry();
    if (context.mounted) Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    final screenWidth = MediaQuery.of(context).size.width;

    // Reduce the bubble width more aggressively on mobile devices.
    double bubbleWidth = screenWidth < 600 ? 160.0 : 200.0;

    // For smaller mobile screens
    if (bubbleWidth > screenWidth * 0.8) {
      bubbleWidth = screenWidth * 0.8;
    }

    // Calculate the horizontal offset to center the bubble above the card
    double dx = -(bubbleWidth / 2) + 20;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: bubbleWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(dx, -120),
          child: Material(
            color: Colors.transparent,
            child: CustomPaint(
              painter: _BubblePainter(),
              child: Padding(
                padding: const .fromLTRB(12, 12, 12, 22),
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: widget.messages
                      .map(
                        (msg) => Text(
                          "• $msg",
                          style: GoogleFonts.aBeeZee(
                            color: Colors.black87,
                            fontSize: 13,
                            fontWeight: .bold,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) {
          _timer = Timer(const Duration(milliseconds: 500), _showBubble);
        },
        onExit: (_) {
          _stopTimerAndHide();
        },
        child: GestureDetector(
          onLongPress: _showBubble,
          onLongPressUp: _stopTimerAndHide,
          child: widget.child,
        ),
      ),
    );
  }

  void _stopTimerAndHide() {
    _timer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = .fill;

    final path = Path()
      ..addRRect(
        RRect.fromLTRBR(
          0,
          0,
          size.width,
          size.height - 10,
          const .circular(12),
        ),
      )
      ..moveTo(size.width / 2 - 10, size.height - 10)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width / 2 + 10, size.height - 10)
      ..close();

    canvas.drawShadow(
      path,
      Colors.black.withAlpha((0.5 * 255).toInt()),
      4.0,
      true,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
