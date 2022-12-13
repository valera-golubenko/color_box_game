part of 'game_cubit.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameLoaded extends GameState {}

class GameError extends GameState {
  final String errorMessage;

  GameError(this.errorMessage);
}
