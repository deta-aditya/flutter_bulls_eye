import 'package:bulls_eye/blocs/high_score/high_score_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bulls_eye/blocs/game/game_bloc.dart';
import 'package:bulls_eye/screens/home_screen.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (BuildContext context) => GameBloc(),
        ),
        BlocProvider<HighScoreBloc>(
          create: (BuildContext context) => HighScoreBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.,
          textTheme: GoogleFonts.rubikTextTheme()
        ),
        home: HomeScreen(),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
