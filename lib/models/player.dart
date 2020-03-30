import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Player extends Equatable {
  final String name;
  final int streak;

  Player({
    @required this.name,
    @required this.streak,
  });

  @override
  List<Object> get props => [name, streak];

  @override
  String toString() {
    return "Player { name: $name, streak: $streak }";
  }

  Player copyWith({ String name, int streak }) {
    return Player(
      name: name ?? this.name,
      streak: streak ?? this.streak,
    );
  }
}
