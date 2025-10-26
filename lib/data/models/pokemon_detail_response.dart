class PokemonDetailResponse {
  final Sprites sprites;
  final PokemonForm form;

  PokemonDetailResponse({required this.sprites, required this.form});

  factory PokemonDetailResponse.fromJson(Map<String, dynamic> json) {
    return PokemonDetailResponse(
      sprites: Sprites.fromJson(json['sprites'] as Map<String, dynamic>),
      form: PokemonForm.fromJson(
        (json['forms'] as List<dynamic>).isNotEmpty
            ? json['forms'][0] as Map<String, dynamic>
            : {},
      ),
    );
  }

  factory PokemonDetailResponse.fromApiJson(Map<String, dynamic> json) {
    final forms = (json['forms'] as List<dynamic>?) ?? [];
    final firstForm = forms.isNotEmpty
        ? Map<String, dynamic>.from(forms.first as Map)
        : <String, dynamic>{};

    return PokemonDetailResponse(
      sprites: Sprites.fromJson(json['sprites'] as Map<String, dynamic>),
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

  Sprites({required this.other});

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      other: Other.fromJson(json['other'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {'other': other.toJson()};
}

class Other {
  final DreamWorld dreamWorld;

  Other({required this.dreamWorld});

  factory Other.fromJson(Map<String, dynamic> json) {
    return Other(
      dreamWorld: DreamWorld.fromJson(
        json['dream_world'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => {'dream_world': dreamWorld.toJson()};
}

class DreamWorld {
  final String frontDefault;

  DreamWorld({required this.frontDefault});

  factory DreamWorld.fromJson(Map<String, dynamic> json) {
    return DreamWorld(frontDefault: json['front_default'] ?? '');
  }

  Map<String, dynamic> toJson() => {'front_default': frontDefault};
}

class PokemonForm {
  final String name;

  PokemonForm({required this.name});

  factory PokemonForm.fromJson(Map<String, dynamic> json) {
    return PokemonForm(name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {'name': name};
}
