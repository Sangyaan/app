// Just for running the our game widget instance
import 'package:app/screens/dyscalculic/game/game/game.dart';
import 'package:app/screens/dyscalculic/game/overlay/gameover.dart';
import 'package:app/screens/dyscalculic/game/overlay/hearts.dart';
import 'package:app/screens/dyscalculic/game/overlay/pause.dart';
import 'package:app/screens/dyscalculic/game/overlay/pause_button.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MathemagicaGame extends StatelessWidget {
  const MathemagicaGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GameWidget(game: RunnerGame(), overlayBuilderMap: {
      "Pause": pauseBuilder,
      "Hearts": heartsBuilder,
      "PauseButton": pauseButton,
      "GameOver": gameOver
    }));
  }
}
