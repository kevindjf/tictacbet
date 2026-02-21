enum Player {
  x,
  o;

  Player get opponent => switch (this) {
    Player.x => Player.o,
    Player.o => Player.x,
  };

  String get symbol => switch (this) {
    Player.x => 'X',
    Player.o => 'O',
  };
}
