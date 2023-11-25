import 'package:native_state_management/app/core/exceptions/app_exceptions.dart';

class PokemonException implements AppException {
  const PokemonException(
    this.message, {
    this.stackTrace,
  });

  @override
  final String message;

  @override
  final StackTrace? stackTrace;
}
