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
  final Other other;

  const Sprites({required this.other});

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(other: Other.fromJson(json['other'] ?? {}));
  }

  Map<String, dynamic> toJson() => {'other': other.toJson()};
}

class Other {
  final DreamWorld dreamWorld;

  const Other({required this.dreamWorld});

  factory Other.fromJson(Map<String, dynamic> json) {
    return Other(dreamWorld: DreamWorld.fromJson(json['dream_world'] ?? {}));
  }

  Map<String, dynamic> toJson() => {'dream_world': dreamWorld.toJson()};
}

class DreamWorld {
  final String frontDefault;

  const DreamWorld({required this.frontDefault});

  factory DreamWorld.fromJson(Map<String, dynamic> json) {
    return DreamWorld(frontDefault: json['front_default'] ?? '');
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
