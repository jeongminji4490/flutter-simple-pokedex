class PokemonDetailResponse {
  final String name;
  final Sprites sprites;
  final List<Ability> abilities;
  final List<PokemonType> types;

  const PokemonDetailResponse({
    required this.name,
    required this.sprites,
    required this.abilities,
    required this.types,
  });

  factory PokemonDetailResponse.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? '';

    // Handle abilities parsing with nested structure
    final abilityList = (json['abilities'] as List<dynamic>?) ?? [];
    final formattedAbilities = abilityList
        .map(
          (item) => Ability.fromJson(item['ability'] as Map<String, dynamic>),
        )
        .toList();

    // Handle types parsing with nested structure
    final typeList = (json['types'] as List<dynamic>?) ?? [];
    final formattedTypes = typeList
        .map(
          (item) => PokemonType.fromJson(item['type'] as Map<String, dynamic>),
        )
        .toList();

    return PokemonDetailResponse(
      name: name,
      sprites: Sprites.fromJson(json['sprites'] ?? {}),
      abilities: formattedAbilities,
      types: formattedTypes,
    );
  }
}

class Sprites {
  final Versions versions;

  const Sprites({required this.versions});

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(versions: Versions.fromJson(json['versions'] ?? {}));
  }

  Map<String, dynamic> toJson() => {'versions': versions.toJson()};
}

class Versions {
  final GenerationV generationV;

  const Versions({required this.generationV});

  factory Versions.fromJson(Map<String, dynamic> json) {
    return Versions(
      generationV: GenerationV.fromJson(json['generation-v'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {'generation-v': generationV.toJson()};
}

class GenerationV {
  final BlackWhite blackWhite;

  const GenerationV({required this.blackWhite});

  factory GenerationV.fromJson(Map<String, dynamic> json) {
    return GenerationV(
      blackWhite: BlackWhite.fromJson(json['black-white'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {'black-white': blackWhite.toJson()};
}

class BlackWhite {
  final Animated animated;

  const BlackWhite({required this.animated});

  factory BlackWhite.fromJson(Map<String, dynamic> json) {
    return BlackWhite(animated: Animated.fromJson(json['animated'] ?? {}));
  }

  Map<String, dynamic> toJson() => {'animated': animated.toJson()};
}

class Animated {
  final String frontDefault;

  const Animated({required this.frontDefault});

  factory Animated.fromJson(Map<String, dynamic> json) {
    return Animated(frontDefault: json['front_default'] ?? '');
  }

  Map<String, dynamic> toJson() => {'front_default': frontDefault};
}

class Ability {
  final String name;

  const Ability({required this.name});

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(name: json['name'] ?? '');
  }
}

class PokemonType {
  final String name;

  const PokemonType({required this.name});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(name: json['name'] ?? '');
  }
}

// Actual Response Example
// API Docs: https://pokeapi.co/docs/v2#pokemon
// {
//.  "name": "venusaur",
//   "abilities": [
//     {
//       "ability": {
//         "name": "overgrow",
//         "url": "https://pokeapi.co/api/v2/ability/65/"
//       },
//       "is_hidden": false,
//       "slot": 1
//     },
//     {
//       "ability": {
//         "name": "chlorophyll",
//         "url": "https://pokeapi.co/api/v2/ability/34/"
//       },
//       "is_hidden": true,
//       "slot": 3
//     }
//   ],
//   "base_experience": 236,
//   "cries": {
//     "latest": "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/3.ogg",
//     "legacy": "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/legacy/3.ogg"
//   },
//   "forms": [
//     {
//       "name": "venusaur",
//       "url": "https://pokeapi.co/api/v2/pokemon-form/3/"
//     }
//   ],
//   "game_indices": [
//     {
//       "game_index": 154,
//       "version": {
//         "name": "red",
//         "url": "https://pokeapi.co/api/v2/version/1/"
//       }
//     }
//   ],
//   "height": 20,
//   "held_items": [],
//   "id": 3,
//   "is_default": true,
//   "location_area_encounters": "https://pokeapi.co/api/v2/pokemon/3/encounters",
//   "moves": [
//     {
//       "move": {
//         "name": "swords-dance",
//         "url": "https://pokeapi.co/api/v2/move/14/"
//       },
//       "version_group_details": [
//         {
//           "level_learned_at": 0,
//           "move_learn_method": {
//             "name": "machine",
//             "url": "https://pokeapi.co/api/v2/move-learn-method/4/"
//           },
//           "version_group": {
//             "name": "red-blue",
//             "url": "https://pokeapi.co/api/v2/version-group/1/"
//           }
//         }
//       ]
//     }
//   ]
// }
