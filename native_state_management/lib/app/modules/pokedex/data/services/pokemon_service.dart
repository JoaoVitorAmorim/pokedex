import 'dart:convert';
import 'package:native_state_management/app/core/exceptions/app_exceptions.dart';
import 'package:native_state_management/app/core/routes/routes.dart';
import 'package:native_state_management/app/core/services/request_response/interface/iservice_web_request.dart';
import 'package:native_state_management/app/core/services/request_response/interface/iservice_web_response.dart';
import 'package:native_state_management/app/core/services/request_response/service_web_request.dart';
import 'package:native_state_management/app/modules/pokedex/data/services/ipokemon_service.dart';
import 'package:native_state_management/app/modules/pokedex/interector/adapter/pokemon_adapter.dart';
import 'package:native_state_management/app/modules/pokedex/interector/exception/pokemon_exception.dart';
import 'package:native_state_management/app/modules/pokedex/interector/models/pokemon.dart';
import 'package:native_state_management/app/modules/pokedex/interector/state/pokemon_state.dart';

class PokemonService implements IPokemonService {
  int limit = 8;
  static String? nextUrl;
  final IServiceWebRequest _iServiceWebRequest = const ServiceWebHttp();

  @override
  Future<PokemonState> getPokemons() async {
    try {
      final response = await _iServiceWebRequest.get(
        nextUrl != null ? nextUrl! : '${Routes.baseUrl}pokemon/?limit=$limit',
      );
      if (response.statusCode != 200) {
        return const PokemonStateFailure(
          PokemonException('Unexpected API return :/'),
        );
      }
      nextUrl = jsonDecode(
        response.body,
      )['next'];

      final pokemons = List<Map<String, dynamic>>.from(
        jsonDecode(
          response.body,
        )['results'],
      )
          .map(
            PokemonAdapter.fromJson,
          )
          .toList();

      await Future.delayed(const Duration(seconds: 1));

      return PokemonListStateSuccess(pokemons);
    } on AppException catch (error) {
      return PokemonStateFailure(
        PokemonException(
          error.message,
        ),
      );
    }
  }

  @override
  Future<PokemonState> completeListPokemon(List<Pokemon> pokemons) async {
    try {
      final List<Future<IServiceWebResponse>> futureRequests = [];
      for (final Pokemon p in pokemons) {
        if (p.url != null) {
          futureRequests.add(
            _iServiceWebRequest.get(p.url!),
          );
        }
      }

      final List<IServiceWebResponse> results =
          await Future.wait(futureRequests);

      final fullListPokemons = List<Map<String, dynamic>>.from(
        [
          for (final result in results)
            jsonDecode(
              result.body,
            )
        ],
      )
          .map(
            PokemonAdapter.fromJsonComplete,
          )
          .toList();

      return PokemonCompleteLoadListSuccess(fullListPokemons);
    } on AppException catch (error) {
      return PokemonStateFailure(error);
    }
  }
}
