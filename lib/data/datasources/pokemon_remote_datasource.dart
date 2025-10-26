import 'package:dio/dio.dart';
import 'package:pokedex_riverpod/data/models/pokemon_detail_response.dart';

class PokemonRemoteDatasource {
  final Dio dio;

  const PokemonRemoteDatasource({required this.dio});

  Future<PokemonDetailResponse> getPokemonImage(int id) async {
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$id');
    return PokemonDetailResponse.fromApiJson(response.data);
  }
}
