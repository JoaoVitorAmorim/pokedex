import 'package:native_state_management/app/core/exceptions/app_exceptions.dart';
import 'package:native_state_management/app/modules/pokedex/interector/models/pokemon.dart';

sealed class PokemonState {}

class PokemonSleeping implements PokemonState {}

class PokemonStateLoading implements PokemonState {}

class PokemonStartAnimation implements PokemonState {}

class PokemonListStateSuccess implements PokemonState {
  final List<Pokemon> pokemons;

  const PokemonListStateSuccess(this.pokemons);
}

class PokemonCompleteLoadListSuccess implements PokemonState {
  final List<Pokemon> pokemons;

  const PokemonCompleteLoadListSuccess(this.pokemons);
}

class PokemonStateFailure implements PokemonState {
  final AppException pokemonException;

  const PokemonStateFailure(this.pokemonException);
}
