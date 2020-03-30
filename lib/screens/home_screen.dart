import 'package:bulls_eye/screens/high_score_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bulls_eye/blocs/game/game_bloc.dart';

import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Bulls Eye", 
                  style: GoogleFonts.chewy(
                    fontSize: 48,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 2,
                        spreadRadius: 0,
                        offset: Offset(1, 4),
                      )
                    ]
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none,
                      hintText: 'Write your name here'
                    ),
                    onSubmitted: (value) {
                      BlocProvider.of<GameBloc>(context).add(NewGame(value));
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => GameScreen()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 8.0,
            right: 8.0,
            child: IconButton(
              icon: Icon(Icons.equalizer), 
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HighScoreScreen()),
              )
            ),
          )
        ],
      )
    );
  }
}