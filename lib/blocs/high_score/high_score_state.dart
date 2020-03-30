part of "high_score_bloc.dart";

class HighScoreState {
  final List<Player> players;
  final bool loaded;

  HighScoreState({ this.players, this.loaded });

  HighScoreState copyWith({ List<Player> players, bool loaded }) {
    return HighScoreState(
      players: players ?? this.players,
      loaded: loaded ?? this.loaded,
    );
  }

  @override
  String toString() {
    return "HighScoreState { players: $players }";
  }
}
