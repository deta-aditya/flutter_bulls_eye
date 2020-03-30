part of "high_score_bloc.dart";

abstract class HighScoreEvent extends Equatable {
  const HighScoreEvent();

  @override
  List<Object> get props => [];
}

class NewHighScore extends HighScoreEvent {
  final Player player;

  NewHighScore(this.player);

  @override
  List<Object> get props => [player];

  @override
  String toString() => "NewHighScore { player: $player }";
}

class WriteHighScore extends HighScoreEvent {
  @override
  String toString() => "WriteHighScore";
}

class ReadHighScore extends HighScoreEvent {
  @override
  String toString() => "ReadHighScore";
}

