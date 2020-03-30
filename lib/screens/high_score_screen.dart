import 'package:bulls_eye/blocs/high_score/high_score_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HighScoreScreen extends StatelessWidget {

  _onWillPop(context) => () {
    BlocProvider.of<HighScoreBloc>(context).add(WriteHighScore());
    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
    return Future(() => false);
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: BlocBuilder<HighScoreBloc, HighScoreState>(
        builder: (context, state) {
          if (! state.loaded) {
            BlocProvider.of<HighScoreBloc>(context).add(ReadHighScore());
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("High Score"),
              brightness: Brightness.light,
              backgroundColor: Colors.transparent,
              textTheme: Theme.of(context).textTheme.copyWith(
                title: Theme.of(context).textTheme.title.copyWith(
                  color: Colors.black,
                )
              ),
              centerTitle: true,
              leading: BackButton(
                color: Colors.black,
                onPressed: _onWillPop(context),
              ),
              elevation: 0,
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              child: ListView.builder(
                itemCount: state.players.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(state.players[index].name),
                    trailing: Text(state.players[index].streak.toString()),
                  );
                }
              ),
            ),
          );
        }
      ), 
      onWillPop: _onWillPop(context),
    );
  }
}
