part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class NewGame extends GameEvent {
  final String playerName;

  NewGame(this.playerName);

  @override
  List<Object> get props => [playerName];

  @override
  String toString() => "CreateNewGame { playerName: $playerName }";
}

class NextStage extends GameEvent {
  @override
  String toString() => "NextStage";
}

class Hit extends GameEvent {
  final int trajectory;

  Hit(this.trajectory);

  @override
  List<Object> get props => [trajectory];

  @override
  String toString() => "Hit { trajectory: $trajectory }";
}

class ResetGame extends GameEvent {
  @override
  String toString() => "ResetGame";
}
