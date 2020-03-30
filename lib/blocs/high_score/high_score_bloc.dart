import 'package:bulls_eye/models/player.dart';
import 'package:bulls_eye/services/high_score_storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "high_score_events.dart";
part "high_score_state.dart";

class HighScoreBloc extends Bloc<HighScoreEvent, HighScoreState> {
  final int highScoreLimit = 5;
  final HighScoreStorageService _storage = HighScoreStorageService();

  @override
  HighScoreState get initialState => HighScoreState(
    players: [],
    loaded: false,
  );

  @override
  Stream<HighScoreState> mapEventToState(HighScoreEvent event) async* {
    if (event is NewHighScore) {
      if (state.players.length < highScoreLimit) {
        yield state.copyWith(
          players: state.players
            ..add(event.player)
            ..sort((prev, next) => next.streak.compareTo(prev.streak))
        );
      } else {
        int playerScore = event.player.streak;
        int lowestHigh = state.players.fold(0, (int accumulation, Player player) => 
          player.streak < playerScore ? accumulation + 1 : accumulation
        );

        if (lowestHigh > 0) {
          yield state.copyWith(
            players: state.players
              ..removeLast()
              ..add(event.player)
              ..sort((prev, next) => next.streak.compareTo(prev.streak))
          );
        }
      }
    }

    if (event is ReadHighScore) {
      List<Player> players = await _storage.readHighScore();
      yield state.copyWith(
        players: players,
        loaded: true,
      );
    }

    if (event is WriteHighScore) {
      await _storage.writeHighScore(state.players);
    }
  }
}