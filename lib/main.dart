import 'package:flutter/material.dart';
import 'package:pokedex_riverpod/presentation/pages/logo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF0C1670),
          onPrimary: Colors.white,
          primaryContainer: Color(0xFF2C3BAF),
          onPrimaryContainer: Colors.white,
          secondary: Color(0xFF5DA0F0),
          onSecondary: Colors.white,
          secondaryContainer: Color(0xFFD6E9FF),
          onSecondaryContainer: Color(0xFF0C1670),
          tertiary: Color(0xFFF5A623),
          onTertiary: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xFF1E1E1E),
          error: Color(0xFFBA1A1A),
          onError: Colors.white,
          outline: Color(0xFF0C1670),
        ),
      ),
      home: Main(),
    );
  }
}
