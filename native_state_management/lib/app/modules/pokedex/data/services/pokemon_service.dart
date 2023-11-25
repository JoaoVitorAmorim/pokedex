import 'dart:convert';

import 'package:native_state_management/app/core/exceptions/app_exceptions.dart';
import 'package:native_state_management/app/core/services/request_response/service_web_request.dart';
import 'package:native_state_management/app/modules/pokedex/data/services/ipokemon_service.dart';
import 'package:native_state_management/app/modules/pokedex/interector/adapter/pokemon_adapter.dart';
import 'package:native_state_management/app/modules/pokedex/interector/state/pokemon_state.dart';

class PokemonService implements IPokemonService {
  @override
  Future<PokemonState> getPokemons() async {
    try {
      final response = await const ServiceWebHttp().get(
        'https://pokeapi.co/api/v2/pokemon/pikachu',
      );

      final pokemons = List<Map<String, dynamic>>.from([
        jsonDecode(
          response.body,
        ),
      ])
          .map(
            PokemonAdapter.fromJson,
          )
          .toList();

      return PokemonStateSuccess(pokemons);
    } on AppException catch (error) {
      return PokemonStateFailure(error);
    }
  }

  @override
  Future<PokemonState> getPokemon() {
    // TODO: implement getPokemon
    throw UnimplementedError();
  }
}
