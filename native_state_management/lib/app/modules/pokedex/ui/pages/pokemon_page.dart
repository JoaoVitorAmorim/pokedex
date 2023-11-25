import 'package:flutter/material.dart';
import 'package:native_state_management/app/modules/pokedex/interector/controllers/pokemon_controller.dart';
import 'package:native_state_management/app/modules/pokedex/interector/state/pokemon_state.dart';

class PokemonPage extends StatefulWidget {
  final PokemonController pokemonController;

  const PokemonPage({
    super.key,
    required this.pokemonController,
  });

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  void initState() {
    super.initState();

    widget.pokemonController.loadPokemons();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: widget.pokemonController,
          builder: (context, state, _) {
            switch (state) {
              case PokemonStateLoading _:
                return Center(
                  key: const ValueKey('Loading'),
                  child: SizedBox(
                    width: size.width * .8,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );

              case PokemonStateSuccess pokemonSuccess:
                return Padding(
                  key: const ValueKey('success'),
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: CustomScrollView(
                    slivers: [
                      const SliverPadding(
                        padding: EdgeInsets.only(
                          left: 60.0 - 25.0,
                          top: 16.0,
                          bottom: 20,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: SizedBox(
                            child: Text('Pokemons'),
                          ),
                        ),
                      ),
                      SliverList.builder(
                        itemCount: pokemonSuccess.pokemons.length,
                        itemBuilder: (context, index) {
                          final pokemon = pokemonSuccess.pokemons[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: Text(pokemon.name),
                          );
                        },
                      ),
                    ],
                  ),
                );

              case PokemonStateFailure _:
                return Container(
                  key: const ValueKey('failure'),
                );

              default:
                return Container(
                  key: const ValueKey('default'),
                  child: Text('default'),
                );
            }
          },
        ),
      ),
    );
  }
}
