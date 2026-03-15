import 'package:dio/dio.dart';
import 'package:pokedex_riverpod/models/pokemon_model.dart';
import 'package:pokedex_riverpod/models/pokemon_detail_response.dart';

class PokemonService {
  final Dio dio;

  const PokemonService({required this.dio});

  Future<PokemonDetailResponse> getPokemonImage({int? id, String? name}) async {
    final response = await dio.get(
      'https://pokeapi.co/api/v2/pokemon/${id ?? name}',
    );
    return PokemonDetailResponse.fromJson(response.data);
  }
}

class PokemonRepository {
  final PokemonService service;

  const PokemonRepository({required this.service});

  Future<Pokemon> getPokemon({int? id, String? name}) async {
    final response = await service.getPokemonImage(id: id, name: name);
    return Pokemon(
      name: response.name,
      image: response
          .sprites
          .versions
          .generationV
          .blackWhite
          .animated
          .frontDefault,
      types: response.types.map((type) => type.name).join(', '),
      abilities: response.abilities.map((ability) => ability.name).join(', '),
    );
  }
}
