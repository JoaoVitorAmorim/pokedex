import 'package:flutter/material.dart';
import 'package:native_state_management/app/modules/pokedex/data/services/pokemon_service.dart';
import 'package:native_state_management/app/modules/pokedex/interector/models/pokemon.dart';
import 'package:native_state_management/app/modules/pokedex/interector/state/pokemon_state.dart';

class PokemonController extends ValueNotifier<PokemonState> {
  final PokemonService pokemonService;

  Future loadPokemons() async {
    value = PokemonStateLoading();
    final pokemonState = await pokemonService.getPokemons();
    value = pokemonState;
    return;
  }

  Future completeLoadPokemons(List<Pokemon> pokemons) async {
    final pokemonState = await pokemonService.completeListPokemon(pokemons);
    value = pokemonState;
    return;
  }

  Future startIntroAnimation() async {
    value = PokemonStartAnimation();
    return;
  }

  PokemonController({required this.pokemonService})
      : super(PokemonStartAnimation());
}
