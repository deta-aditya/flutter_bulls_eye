import 'dart:math';

import 'package:bulls_eye/models/player.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';
part 'game_events.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameState get initialState => GameState(
    currentPlayer: null, 
    health: 0,
    target: 0,
  );

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is NewGame) {
      yield state.copyWith(
        currentPlayer: Player(name: event.playerName, streak: 0),
        health: 100,
      );
    }
    
    if (event is NextStage) {
      yield state.copyWith(
        target: Random.secure().nextInt(100)
      );
    }
    
    if (event is Hit) {
      int damage = (state.target - event.trajectory).abs();
      int newHealth = max(state.health - damage, 0);

      if (newHealth > 0) {
        yield state.copyWith(
          currentPlayer: state.currentPlayer.copyWith(
            streak: state.currentPlayer.streak + 1 
          ),
          health: newHealth,
        );
      } else {
        yield state.copyWith(
          health: newHealth,
        );
      }
    }

    if (event is ResetGame) {
      yield initialState;
    }
  }  
}
