import 'package:dio/dio.dart';
import 'package:pokedex_riverpod/models/pokemon_model.dart';
import 'package:pokedex_riverpod/models/pokemon_detail_response.dart';

class PokemonService {
  final Dio dio;

  const PokemonService({required this.dio});

  Future<PokemonDetailResponse> getPokemonImage(int id) async {
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');
    return PokemonDetailResponse.fromJson(response.data);
  }
}

class PokemonRepository {
  final PokemonService service;

  const PokemonRepository({required this.service});

  Future<Pokemon> getPokemon(int id) async {
    final response = await service.getPokemonImage(id);
    return Pokemon(
      name: response.form.name,
      image: response
          .sprites
          .versions
          .generationV
          .blackWhite
          .animated
          .frontDefault,
    );
  }
}
