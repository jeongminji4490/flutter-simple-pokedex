class PokemonListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonResult> results;

  PokemonListResponse({
    this.count = 0,
    this.next,
    this.previous,
    this.results = const [],
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>)
          .map((e) => PokemonResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PokemonResult {
  final String name;
  final String url;

  PokemonResult({required this.name, required this.url});

  factory PokemonResult.fromJson(Map<String, dynamic> json) {
    return PokemonResult(name: json['name'] ?? '', url: json['url'] ?? '');
  }
}

// Actual Response Example
// API Docs: https://pokeapi.co/docs/v2#pokemon
// {
//   "count": 1350,
//   "next": "https://pokeapi.co/api/v2/pokemon?offset=31&limit=10",
//   "previous": "https://pokeapi.co/api/v2/pokemon?offset=11&limit=3",
//   "results": [
//     {
//       "name": "fearow",
//       "url": "https://pokeapi.co/api/v2/pokemon/22/"
//     },
//     {
//       "name": "ekans",
//       "url": "https://pokeapi.co/api/v2/pokemon/23/"
//     },
//     {
//       "name": "arbok",
//       "url": "https://pokeapi.co/api/v2/pokemon/24/"
//     },
//   ]
// }
