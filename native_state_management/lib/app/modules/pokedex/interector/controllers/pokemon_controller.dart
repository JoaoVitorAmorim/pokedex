import 'package:flutter/material.dart';
import 'package:native_state_management/app/modules/pokedex/data/services/pokemon_service.dart';
import 'package:native_state_management/app/modules/pokedex/interector/state/pokemon_state.dart';

class PokemonController extends ValueNotifier<PokemonState> {
  final PokemonService pokemonService;

  Future loadPokemons() async {
    final pokemonState = await pokemonService.getPokemons();
    value = pokemonState;
    return;
  }

  Future loadPokemo() async {
    final pokemonState = await pokemonService.getPokemon();
    value = pokemonState;
    return;
  }

  PokemonController({required this.pokemonService})
      : super(PokemonStateLoading());
}
