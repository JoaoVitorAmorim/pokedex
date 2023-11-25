import 'package:get_it/get_it.dart';
import 'package:native_state_management/app/core/utils/singleton.dart';
import 'package:native_state_management/app/modules/pokedex/data/services/pokemon_service.dart';
import 'package:native_state_management/app/modules/pokedex/interector/controllers/pokemon_controller.dart';

var getIt = GetIt.instance;

Singleton setup() {
  getIt = GetIt.asNewInstance();

  getIt.registerSingleton<PokemonService>(
    PokemonService(),
  );

  getIt.registerSingleton<PokemonController>(
    PokemonController(
      pokemonService: getIt.get<PokemonService>(),
    ),
  );
  return singleton;
}
