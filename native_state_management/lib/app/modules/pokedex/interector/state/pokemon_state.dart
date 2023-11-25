import 'package:native_state_management/app/core/exceptions/app_exceptions.dart';
import 'package:native_state_management/app/modules/pokedex/interector/models/pokemon.dart';

sealed class PokemonState {}

class PokemonStateLoading implements PokemonState {}

class PokemonStateSuccess implements PokemonState {
  final List<Pokemon> pokemons;

  const PokemonStateSuccess(this.pokemons);
}

class PokemonStateFailure implements PokemonState {
  final AppException pokemonException;

  const PokemonStateFailure(this.pokemonException);
}
