class PokemonDetailResponse {
  final Sprites sprites;
  final PokemonForm form;

  const PokemonDetailResponse({required this.sprites, required this.form});

  factory PokemonDetailResponse.fromJson(Map<String, dynamic> json) {
    final forms = (json['forms'] as List<dynamic>?) ?? [];
    final firstForm = forms.isNotEmpty
        ? Map<String, dynamic>.from(forms.first as Map)
        : <String, dynamic>{};

    return PokemonDetailResponse(
      sprites: Sprites.fromJson(json['sprites'] ?? {}),
      form: PokemonForm.fromJson(firstForm),
    );
  }

  Map<String, dynamic> toJson() => {
    'sprites': sprites.toJson(),
    'form': form.toJson(),
  };
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

class PokemonForm {
  final String name;

  const PokemonForm({required this.name});

  factory PokemonForm.fromJson(Map<String, dynamic> json) {
    return PokemonForm(name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'name': name};
}

// class Sprites {
//   final Other other;

//   const Sprites({required this.other});

//   factory Sprites.fromJson(Map<String, dynamic> json) {
//     return Sprites(other: Other.fromJson(json['other'] ?? {}));
//   }

//   Map<String, dynamic> toJson() => {'other': other.toJson()};
// }

// class Other {
//   final DreamWorld dreamWorld;

//   const Other({required this.dreamWorld});

//   factory Other.fromJson(Map<String, dynamic> json) {
//     return Other(dreamWorld: DreamWorld.fromJson(json['dream_world'] ?? {}));
//   }

//   Map<String, dynamic> toJson() => {'dream_world': dreamWorld.toJson()};
// }

// class DreamWorld {
//   final String frontDefault;

//   const DreamWorld({required this.frontDefault});

//   factory DreamWorld.fromJson(Map<String, dynamic> json) {
//     return DreamWorld(frontDefault: json['front_default'] ?? '');
//   }

//   Map<String, dynamic> toJson() => {'front_default': frontDefault};
// }

// class PokemonForm {
//   final String name;

//   const PokemonForm({required this.name});

//   factory PokemonForm.fromJson(Map<String, dynamic> json) {
//     return PokemonForm(name: json['name'] ?? '');
//   }

//   Map<String, dynamic> toJson() => {'name': name};
// }
