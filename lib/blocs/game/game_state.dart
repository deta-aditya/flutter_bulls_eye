part of 'game_bloc.dart';

class GameState {
  Player currentPlayer;
  int target;
  int health;

  bool get isGameOver => health == 0;

  GameState({
    this.currentPlayer,
    this.target,
    this.health,
  });

  GameState copyWith({ Player currentPlayer, int target, int health }) {
    return GameState(
      currentPlayer: currentPlayer ?? this.currentPlayer,
      target: target ?? this.target,
      health: health ?? this.health,
    );
  }

  @override
  String toString() {
    return "GameBlocState { currentPlayer: $currentPlayer, target: $target, health: $health }";
  }
}
