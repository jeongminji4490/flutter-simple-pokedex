import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_riverpod/models/pokemon_list_response.dart';
import 'package:pokedex_riverpod/models/pokemon_model.dart';
import 'package:pokedex_riverpod/models/pokemon_detail_response.dart';

final dioProvider = Provider((ref) => Dio());

final serviceProvider = Provider(
  (ref) => PokemonService(dio: ref.watch(dioProvider)),
);

final pokemonRepositoryProvider = Provider(
  (ref) => PokemonRepository(service: ref.watch(serviceProvider)),
);

class PokemonService {
  final Dio dio;

  const PokemonService({required this.dio});

  // Load pokemon list with pagination
  Future<PokemonListResponse> getPokemons({String? url}) async {
    final response = await dio.get(
      url ??
          'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0', // initial load
    );
    return PokemonListResponse.fromJson(response.data);
  }

  // Load pokemon detail by name
  Future<PokemonDetailResponse> getPokemonDetail(String name) async {
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$name');
    return PokemonDetailResponse.fromJson(response.data);
  }
}

class PokemonRepository {
  final PokemonService service;

  const PokemonRepository({required this.service});

  Future<Pokemon> getPokemonDetail(String name) async {
    final response = await service.getPokemonDetail(name);
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
