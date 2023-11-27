import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:native_state_management/app/modules/pokedex/interector/controllers/pokemon_controller.dart';
import 'package:native_state_management/app/modules/pokedex/interector/models/pokemon.dart';
import 'package:native_state_management/app/modules/pokedex/interector/state/pokemon_state.dart';
import 'package:native_state_management/app/modules/pokedex/ui/pages/pokemon_error_page.dart';
import 'package:native_state_management/app/modules/pokedex/ui/pages/pokemon_intro.dart';
import 'package:native_state_management/app/modules/pokedex/ui/widgets/pokemon_tile.dart';

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
  late ScrollController _controller;
  static final List<Widget> _children = [];
  static double scrollHeigth = 0;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      widget.pokemonController.loadPokemons();
    }
    scrollHeigth = _controller.offset;
  }

  _pokemonListener() {
    if (widget.pokemonController.value.runtimeType == PokemonStateFailure) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const PokemonErrorPage();
          },
        ),
      );
    }
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    result = await _connectivity.checkConnectivity();
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(
      () {
        _connectionStatus = result;
      },
    );
    if (_connectionStatus == ConnectivityResult.none) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const PokemonErrorPage();
          },
        ),
      );
    }
  }

  triggerFirstLoad() async {
    await Future.delayed(const Duration(milliseconds: 4000))
        .then((value) => widget.pokemonController.loadPokemons());
  }

  @override
  void initState() {
    triggerFirstLoad();

    _controller = ScrollController(
      initialScrollOffset: scrollHeigth,
    );

    _controller.addListener(_scrollListener);
    widget.pokemonController.addListener(_pokemonListener);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: const Color(0xFFFFFFFF),
        child: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: widget.pokemonController,
              builder: (context, state, _) {
                if (state is PokemonStartAnimation) {
                  return const PokemonIntro();
                }
                return Padding(
                  key: const ValueKey('success'),
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: CustomScrollView(
                    controller: _controller,
                    slivers: [
                      const SliverPadding(
                        padding: EdgeInsets.only(
                          left: 60.0 - 25.0,
                          top: 16.0,
                          bottom: 20,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: widget.pokemonController,
                        builder: (context, state, _) {
                          if (state is PokemonListStateSuccess) {
                            widget.pokemonController
                                .completeLoadPokemons(state.pokemons);
                          }
                          if (state is PokemonCompleteLoadListSuccess) {
                            for (final Pokemon p in state.pokemons) {
                              _children.add(
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: PokemonTile(
                                    p: p,
                                  ),
                                ),
                              );
                            }
                          }
                          return SliverList.list(
                            children: [
                              ..._children,
                              if (state is PokemonStateLoading)
                                Center(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'loading.gif',
                                        height: 40,
                                      ),
                                      const Text('Loading...'),
                                    ],
                                  ),
                                )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
