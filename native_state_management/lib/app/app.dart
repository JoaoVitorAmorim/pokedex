import 'package:flutter/material.dart';
import 'package:native_state_management/app/di.dart';
import 'package:native_state_management/app/modules/pokedex/interector/controllers/pokemon_controller.dart';
import 'package:native_state_management/app/modules/pokedex/ui/pages/pokemon_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) {
          return PokemonPage(
            pokemonController: getIt.get<PokemonController>(),
          );
        },
      },
    );
  }
}
