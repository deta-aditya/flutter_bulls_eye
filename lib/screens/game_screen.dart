import 'package:bulls_eye/blocs/game/game_bloc.dart';
import 'package:bulls_eye/blocs/high_score/high_score_bloc.dart';
import 'package:bulls_eye/screens/high_score_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double _value = 50.0;
  GameBloc _game;
  HighScoreBloc _highScore;

  @override
  void initState() {
    super.initState();
    _game = BlocProvider.of<GameBloc>(context);
    _highScore = BlocProvider.of<HighScoreBloc>(context);
    _game.add(NextStage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listenWhen: (oldState, newState) {
        return oldState.health != newState.health ||
          oldState.currentPlayer?.streak != newState.currentPlayer?.streak; 
      },
      listener: (context, state) {
        if (state.isGameOver) {
          _highScore.add(NewHighScore(state.currentPlayer));
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Game Over"),
                content: Text("Your streak: ${state.currentPlayer.streak}"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Finish"),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HighScoreScreen()));
                    },
                  )
                ],
              );
            }
          );
        } else {
          _game.add(NextStage());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text(state.currentPlayer.name),
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            textTheme: Theme.of(context).textTheme.copyWith(
              title: Theme.of(context).textTheme.title.copyWith(
                color: Colors.black,
              )
            ),
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
          ),
          body: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 18.0
                    ),
                    child: Text(
                      state.target.toString(),
                      style: TextStyle(
                        fontSize: 48,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: SliderTheme(
                      child: Slider(
                        value: _value, 
                        min: 0,
                        max: 100,
                        onChanged: (double value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ), 
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 25,
                        activeTrackColor: Colors.grey[300],
                        inactiveTrackColor: Colors.grey[300],
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 30),
                        thumbColor: Colors.redAccent,
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 40),
                        overlayColor: Colors.redAccent.withOpacity(0.7),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 32.0,
                    ),
                    child: RaisedButton(
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        "Hit",
                        style: TextStyle(
                          fontSize: 24.0
                        ),
                      ),
                      onPressed: () {
                        _game.add(Hit(_value.toInt()));
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Health: ${state.health}"),
                    Text("Streak: ${state.currentPlayer.streak}"),
                  ]
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
