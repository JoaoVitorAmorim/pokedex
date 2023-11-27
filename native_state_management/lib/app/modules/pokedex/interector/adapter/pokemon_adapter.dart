import 'package:native_state_management/app/core/types/types.dart';
import 'package:native_state_management/app/modules/pokedex/interector/models/pokemon.dart';

class PokemonAdapter {
  static Pokemon fromJson(Json json) => Pokemon(
        name: json['name'],
        url: json['url'],
      );

  static Pokemon fromJsonComplete(Json json) => Pokemon(
        id: json['id'],
        name: json['name'],
        frontDefault: json['sprites']['front_default'],
      );
}
